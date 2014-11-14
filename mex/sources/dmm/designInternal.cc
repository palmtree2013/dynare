#include <dynmex.h>
#include <algorithm>
using namespace std;

extern "C"
void designInternal(int ny, int nz, int nx, int nu, int ns[6], int nt,
                    double *theta, char *mfile,
                    double *c, double *H, double *G, double *a, double *F, double *R)
{
  mxArray *lhs[6], *rhs[6];
  nz = max(1, nz);
  const mwSize dimsC[] = {ny, nz, ns[0]};
  const mwSize dimsH[] = {ny, nx, ns[1]};
  const mwSize dimsG[] = {ny, nu, ns[2]};
  const mwSize dimsA[] = {nx,     ns[3]};
  const mwSize dimsF[] = {nx, nx, ns[4]};
  const mwSize dimsR[] = {nx, nu, ns[5]};

  lhs[0] = mxCreateNumericArray(3, dimsC, mxDOUBLE_CLASS, mxREAL);
  lhs[1] = mxCreateNumericArray(3, dimsH, mxDOUBLE_CLASS, mxREAL);
  lhs[2] = mxCreateNumericArray(3, dimsG, mxDOUBLE_CLASS, mxREAL);
  lhs[3] = mxCreateNumericArray(2, dimsA, mxDOUBLE_CLASS, mxREAL);
  lhs[4] = mxCreateNumericArray(3, dimsF, mxDOUBLE_CLASS, mxREAL);
  lhs[5] = mxCreateNumericArray(3, dimsR, mxDOUBLE_CLASS, mxREAL);

  rhs[0] = mxCreateDoubleScalar(ny);
  rhs[1] = mxCreateDoubleScalar(nz);
  rhs[2] = mxCreateDoubleScalar(nx);
  rhs[3] = mxCreateDoubleScalar(nu);
  rhs[4] = mxCreateDoubleMatrix(1, 6,  mxREAL);
  rhs[5] = mxCreateDoubleMatrix(1, nt, mxREAL);

  double *passns = mxGetPr(rhs[4]);
  for (int i = 0; i < 6; i++)
    passns[i] = (double) ns[i];
  memcpy(mxGetPr(rhs[5]), theta, sizeof(double) * nt);

  mexCallMATLAB(6, lhs, 6, rhs, mfile);

  memcpy(c, mxGetPr(lhs[0]), sizeof(double) * mxGetNumberOfElements(lhs[0]));
  memcpy(H, mxGetPr(lhs[1]), sizeof(double) * mxGetNumberOfElements(lhs[1]));
  memcpy(G, mxGetPr(lhs[2]), sizeof(double) * mxGetNumberOfElements(lhs[2]));
  memcpy(a, mxGetPr(lhs[3]), sizeof(double) * mxGetNumberOfElements(lhs[3]));
  memcpy(F, mxGetPr(lhs[4]), sizeof(double) * mxGetNumberOfElements(lhs[4]));
  memcpy(R, mxGetPr(lhs[5]), sizeof(double) * mxGetNumberOfElements(lhs[5]));
}
