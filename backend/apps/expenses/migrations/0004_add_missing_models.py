import django.db.models.deletion
import django.utils.timezone
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('expenses', '0003_add_tw_withdrawal_type'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [

        # ── TransactionAuditLog ──────────────────────────────────────────────
        migrations.CreateModel(
            name='TransactionAuditLog',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('timestamp', models.DateTimeField(auto_now_add=True)),
                ('action', models.CharField(
                    choices=[('create', 'Created'), ('update', 'Updated'), ('delete', 'Deleted')],
                    max_length=10,
                )),
                ('transaction_id', models.IntegerField()),
                ('transaction_name', models.CharField(max_length=255)),
                ('changes', models.JSONField(blank=True, default=dict)),
                ('user', models.ForeignKey(
                    blank=True, null=True,
                    on_delete=django.db.models.deletion.SET_NULL,
                    related_name='audit_logs',
                    to=settings.AUTH_USER_MODEL,
                )),
            ],
            options={'ordering': ['-timestamp']},
        ),

        # ── TransactionTemplate ──────────────────────────────────────────────
        migrations.CreateModel(
            name='TransactionTemplate',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('label', models.CharField(max_length=100, unique=True)),
                ('name', models.CharField(max_length=255, verbose_name='Description')),
                ('amount', models.DecimalField(blank=True, decimal_places=2, max_digits=12, null=True)),
                ('currency', models.CharField(default='TWD', max_length=3)),
                ('transaction_type', models.CharField(
                    choices=[
                        ('expense', 'Expense'), ('income', 'Income'),
                        ('transfer', 'Transfer'), ('topup', 'Top-up'),
                        ('ph_withdrawal', 'PH Withdrawal'), ('tw_withdrawal', 'TW Withdrawal'),
                    ],
                    default='expense', max_length=15,
                )),
                ('notes', models.TextField(blank=True, default='')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('category', models.ForeignKey(
                    blank=True, null=True,
                    on_delete=django.db.models.deletion.SET_NULL,
                    related_name='templates', to='expenses.category',
                )),
                ('payment_method', models.ForeignKey(
                    blank=True, null=True,
                    on_delete=django.db.models.deletion.SET_NULL,
                    related_name='templates', to='expenses.paymentmethod',
                )),
                ('to_payment_method', models.ForeignKey(
                    blank=True, null=True,
                    on_delete=django.db.models.deletion.SET_NULL,
                    related_name='templates_incoming', to='expenses.paymentmethod',
                )),
            ],
            options={'ordering': ['label']},
        ),

        # ── TransactionAttachment ────────────────────────────────────────────
        migrations.CreateModel(
            name='TransactionAttachment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('file', models.FileField(upload_to='attachments/%Y/%m/')),
                ('original_name', models.CharField(max_length=255)),
                ('uploaded_at', models.DateTimeField(auto_now_add=True)),
                ('transaction', models.ForeignKey(
                    on_delete=django.db.models.deletion.CASCADE,
                    related_name='attachments', to='expenses.transaction',
                )),
            ],
            options={'ordering': ['-uploaded_at']},
        ),

        # ── SharedExpense ────────────────────────────────────────────────────
        migrations.CreateModel(
            name='SharedExpense',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('member_name', models.CharField(max_length=100)),
                ('share_amount', models.DecimalField(decimal_places=2, max_digits=12)),
                ('currency', models.CharField(default='TWD', max_length=3)),
                ('is_settled', models.BooleanField(default=False)),
                ('settled_at', models.DateTimeField(blank=True, null=True)),
                ('notes', models.TextField(blank=True, default='')),
                ('transaction', models.ForeignKey(
                    on_delete=django.db.models.deletion.CASCADE,
                    related_name='shared_splits', to='expenses.transaction',
                )),
            ],
            options={'ordering': ['transaction', 'member_name']},
        ),

        # ── UserPreference ───────────────────────────────────────────────────
        migrations.CreateModel(
            name='UserPreference',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('theme', models.CharField(
                    choices=[('dark', 'Dark'), ('light', 'Light')],
                    default='dark', max_length=10,
                )),
                ('default_currency', models.CharField(default='TWD', max_length=3)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('user', models.OneToOneField(
                    on_delete=django.db.models.deletion.CASCADE,
                    related_name='preference', to=settings.AUTH_USER_MODEL,
                )),
            ],
            options={'verbose_name': 'User Preference'},
        ),
    ]
