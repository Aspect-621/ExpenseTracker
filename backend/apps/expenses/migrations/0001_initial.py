from django.db import migrations, models
import django.db.models.deletion
import datetime


class Migration(migrations.Migration):
    initial = True
    dependencies = [('accounts', '0001_initial')]
    operations = [
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=100, unique=True)),
                ('color', models.CharField(default='#0d6efd', max_length=7)),
                ('icon', models.CharField(default='tag', max_length=50)),
                ('is_active', models.BooleanField(default=True)),
                ('order', models.IntegerField(default=0)),
            ],
            options={'ordering':['order','name'],'verbose_name_plural':'Categories'},
        ),
        migrations.CreateModel(
            name='PaymentMethod',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=100, unique=True)),
                ('color', models.CharField(default='#6c757d', max_length=7)),
                ('is_bank_account', models.BooleanField(default=False)),
                ('is_active', models.BooleanField(default=True)),
                ('order', models.IntegerField(default=0)),
                ('starting_balance', models.DecimalField(decimal_places=2, default=0, max_digits=12)),
                ('starting_balance_date', models.DateField(blank=True, null=True)),
            ],
            options={'ordering':['order','name']},
        ),
        migrations.CreateModel(
            name='Transaction',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ('date', models.DateField(default=datetime.date.today)),
                ('name', models.CharField(max_length=255)),
                ('amount', models.DecimalField(decimal_places=2, max_digits=12)),
                ('currency', models.CharField(default='TWD', max_length=3)),
                ('transaction_type', models.CharField(choices=[('expense','Expense'),('income','Income'),('transfer','Transfer'),('topup','Top-up')], default='expense', max_length=10)),
                ('notes', models.TextField(blank=True, default='')),
                ('is_hidden', models.BooleanField(default=False)),
                ('is_recurring_instance', models.BooleanField(default=False)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('payment_method', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='transactions', to='expenses.paymentmethod')),
                ('to_payment_method', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='incoming_transfers', to='expenses.paymentmethod')),
                ('category', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='transactions', to='expenses.category')),
            ],
            options={'ordering':['-date','-created_at']},
        ),
        migrations.CreateModel(
            name='BudgetLimit',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ('month', models.DateField()),
                ('amount', models.DecimalField(decimal_places=2, max_digits=12)),
                ('currency', models.CharField(default='TWD', max_length=3)),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='budgets', to='expenses.category')),
            ],
            options={'ordering':['-month','category'],'unique_together':{('category','month')}},
        ),
        migrations.CreateModel(
            name='RecurringExpense',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=255)),
                ('amount', models.DecimalField(decimal_places=2, max_digits=12)),
                ('currency', models.CharField(default='TWD', max_length=3)),
                ('transaction_type', models.CharField(choices=[('expense','Expense'),('income','Income'),('transfer','Transfer'),('topup','Top-up')], default='expense', max_length=10)),
                ('notes', models.TextField(blank=True, default='')),
                ('day_of_month', models.IntegerField(default=1)),
                ('is_active', models.BooleanField(default=True)),
                ('start_date', models.DateField(default=datetime.date.today)),
                ('end_date', models.DateField(blank=True, null=True)),
                ('last_added', models.DateField(blank=True, null=True)),
                ('payment_method', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='recurring', to='expenses.paymentmethod')),
                ('to_payment_method', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, related_name='recurring_incoming', to='expenses.paymentmethod')),
                ('category', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.PROTECT, to='expenses.category')),
            ],
            options={'ordering':['name']},
        ),
    ]
