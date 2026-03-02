from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):
    dependencies = [
        ('expenses', '0001_initial'),
    ]
    operations = [
        migrations.AddField(
            model_name='paymentmethod',
            name='currency',
            field=models.CharField(default='TWD', max_length=3),
        ),
        migrations.AddField(
            model_name='transaction',
            name='exchange_rate',
            field=models.DecimalField(blank=True, decimal_places=6, max_digits=10, null=True),
        ),
        migrations.AddField(
            model_name='transaction',
            name='converted_amount',
            field=models.DecimalField(blank=True, decimal_places=2, max_digits=12, null=True),
        ),
        migrations.AddField(
            model_name='transaction',
            name='paired_transaction',
            field=models.OneToOneField(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='pair', to='expenses.transaction'),
        ),
        migrations.AlterField(
            model_name='transaction',
            name='transaction_type',
            field=models.CharField(choices=[('expense','Expense'),('income','Income'),('transfer','Transfer'),('topup','Top-up'),('ph_withdrawal','PH Withdrawal')], default='expense', max_length=15),
        ),
        migrations.AlterField(
            model_name='recurringexpense',
            name='transaction_type',
            field=models.CharField(choices=[('expense','Expense'),('income','Income'),('transfer','Transfer'),('topup','Top-up'),('ph_withdrawal','PH Withdrawal')], default='expense', max_length=15),
        ),
    ]
