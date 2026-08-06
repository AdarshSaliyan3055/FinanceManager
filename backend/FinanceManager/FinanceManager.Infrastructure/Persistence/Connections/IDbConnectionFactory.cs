using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace FinanceManager.Infrastructure.Persistence.Connections;

public interface IDbConnectionFactory
{ 
        IDbConnection CreateConnection(); 
}