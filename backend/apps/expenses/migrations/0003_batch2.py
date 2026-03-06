from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):
    dependencies = [
        ('expenses', '0002_paymentmethod_currency_transaction_exchange'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        # Update transaction_type choices to include tw_withdrawal
        migrations.AlterField(
            model_name='transaction',
            name='transaction_type',
            field=models.CharField(
                choices=[
                    ('expense','Expense'),('income','Income'),('transfer','Transfer'),
                    ('topup','Top-up'),('ph_withdrawal','PH Withdrawal'),('tw_withdrawal','TW Withdrawal'),
                ],
                default='expense', max_length=15,
            ),
        ),
        migrations.AlterField(
            model_name='recurringexpense',
            name='transaction_type',
            field=models.CharField(
                choices=[
                    ('expense','Expense'),('income','Income'),('transfer','Transfer'),
                    ('topup','Top-up'),('ph_withdrawal','PH Withdrawal'),('tw_withdrawal','TW Withdrawal'),
                ],
                default='expense', max_length=15,
            ),
        ),
        migrations.CreateModel(
            name='TransactionAuditLog',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ('transaction_id', models.IntegerField()),
                ('transaction_name', models.CharField(default='', max_length=255)),
                ('action', models.CharField(choices=[('created','Created'),('updated','Updated'),('deleted','Deleted')], max_length=10)),
                ('changes', models.TextField(blank=True, default='{}')),
                ('timestamp', models.DateTimeField(auto_now_add=True)),
                ('user', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to=settings.AUTH_USER_MODEL)),
            ],
            options={'ordering': ['-timestamp']},
        ),
        migrations.CreateModel(
            name='TransactionTemplate',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ('label', models.CharField(max_length=100)),
                ('name', models.CharField(max_length=255)),
                ('amount', models.DecimalField(decimal_places=2, max_digits=12)),
                ('currency', models.CharField(default='TWD', max_length=3)),
                ('transaction_type', models.CharField(
                    choices=[('expense','Expense'),('income','Income'),('transfer','Transfer'),('topup','Top-up'),('ph_withdrawal','PH Withdrawal'),('tw_withdrawal','TW Withdrawal')],
                    default='expense', max_length=15,
                )),
                ('notes', models.TextField(blank=True, default='')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('category', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='expenses.category')),
                ('payment_method', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='expenses.paymentmethod')),
            ],
            options={'ordering': ['label']},
        ),
        migrations.CreateModel(
            name='TransactionAttachment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ('file', models.FileField(upload_to='attachments/')),
                ('original_name', models.CharField(max_length=255)),
                ('uploaded_at', models.DateTimeField(auto_now_add=True)),
                ('transaction', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='attachments', to='expenses.transaction')),
            ],
            options={'ordering': ['-uploaded_at']},
        ),
        migrations.CreateModel(
            name='SharedExpense',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ('member_name', models.CharField(max_length=100)),
                ('share_amount', models.DecimalField(decimal_places=2, max_digits=12)),
                ('currency', models.CharField(default='TWD', max_length=3)),
                ('is_settled', models.BooleanField(default=False)),
                ('settled_date', models.DateField(blank=True, null=True)),
                ('notes', models.TextField(blank=True, default='')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('transaction', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='shared_with', to='expenses.transaction')),
            ],
            options={'ordering': ['-created_at']},
        ),
        migrations.CreateModel(
            name='UserPreference',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ('theme', models.CharField(choices=[('dark','Dark'),('light','Light')], default='dark', max_length=5)),
                ('default_currency', models.CharField(default='TWD', max_length=3)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='preference', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
