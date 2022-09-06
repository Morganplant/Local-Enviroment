import sys
sys.path.append(r"python")
from results import *
results_index = ResultsIndex('results_index_temp.db')
results_index.add(args.results)
results_index.finalize()
results_index.close()
