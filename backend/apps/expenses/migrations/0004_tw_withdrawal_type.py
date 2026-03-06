from django.db import migrations
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('expenses', '0003_batch2'),
    ]

    operations = [
        migrations.AlterField(
            model_name='transaction',
            name='transaction_type',
            field=django.db.models.fields.CharField(
                choices=[
                    ('expense', 'Expense'),
                    ('income', 'Income'),
                    ('transfer', 'Transfer'),
                    ('topup', 'Top-up'),
                    ('ph_withdrawal', 'PH Withdrawal'),
                    ('tw_withdrawal', 'TW Withdrawal'),
                ],
                default='expense',
                max_length=15,
            ),
        ),
    ]
