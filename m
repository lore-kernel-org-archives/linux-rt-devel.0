Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27E7269CE7
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Jan 2026 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367736; cv=none; b=iWBgsWCoxRbAffBbNL73j2mPeFugYnXYE/prYhQTwjtfDUyMkQoL9tMvUxswmVuilzTsD7wv7puXNf7wEarO/+59eNappldtK4bdwluBUywP5d98TCafo8540bX9DpySA3rqaL+AGxO2h9TXd7yq9+OtCqllDmPincHUj/7Mp10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367736; c=relaxed/simple;
	bh=bWwQkslUTi59G6Sx/Bn5ra5MgEZNdAgS5pk5H94jO7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfneIuT6mF2UKF7xSLhGHXFEmW+aPTMgNo6+3CzXrVSXJXXaInAul/rcM5RaEaI5S12z+VUNdZAA/GYupGX8J3eHsbqXdBmqBzWrTpDErFrcVi1dGINkZHhazTktUFkFw1rd8msgG5uHouT+Tv5q8ArV01+z946USXDx8cH4hZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2145B497;
	Fri,  2 Jan 2026 07:28:47 -0800 (PST)
Received: from [10.57.94.221] (unknown [10.57.94.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D04B83F5A1;
	Fri,  2 Jan 2026 07:28:50 -0800 (PST)
Message-ID: <4a315d79-bf82-4a90-9c9c-8dd1bdc43d38@arm.com>
Date: Fri, 2 Jan 2026 15:28:49 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] arm64: mmu: introduce pgtable_alloc_t
Content-Language: en-GB
To: Yeoreum Yun <yeoreum.yun@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, akpm@linux-foundation.org, david@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
 yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
 vbabka@suse.cz, mhocko@suse.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260102150736.1378818-1-yeoreum.yun@arm.com>
 <20260102150736.1378818-2-yeoreum.yun@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260102150736.1378818-2-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/01/2026 15:07, Yeoreum Yun wrote:
> This is preparation patch to use preallocated page tables
> for linear_map_split_to_ptes().
> 
> Define pgtable_alloc_t type for callback used by create_XXX_mapping().
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/arm64/mm/mmu.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 8e1d80a7033e..4b4908ae189b 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -74,6 +74,8 @@ EXPORT_SYMBOL(empty_zero_page);
>  static DEFINE_SPINLOCK(swapper_pgdir_lock);
>  static DEFINE_MUTEX(fixmap_lock);
>  
> +typedef phys_addr_t (pgtable_alloc_t)(enum pgtable_type);
> +
>  void noinstr set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>  {
>  	pgd_t *fixmap_pgdp;
> @@ -197,7 +199,7 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>  static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  			       unsigned long end, phys_addr_t phys,
>  			       pgprot_t prot,
> -			       phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +			       pgtable_alloc_t pgtable_alloc,
>  			       int flags)
>  {
>  	unsigned long next;
> @@ -252,7 +254,7 @@ static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  
>  static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  		    phys_addr_t phys, pgprot_t prot,
> -		    phys_addr_t (*pgtable_alloc)(enum pgtable_type), int flags)
> +		    pgtable_alloc_t pgtable_alloc, int flags)
>  {
>  	unsigned long next;
>  
> @@ -292,7 +294,7 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  			       unsigned long end, phys_addr_t phys,
>  			       pgprot_t prot,
> -			       phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +			       pgtable_alloc_t pgtable_alloc,
>  			       int flags)
>  {
>  	int ret;
> @@ -349,7 +351,7 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  
>  static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>  			  phys_addr_t phys, pgprot_t prot,
> -			  phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +			  pgtable_alloc_t pgtable_alloc,
>  			  int flags)
>  {
>  	int ret = 0;
> @@ -415,7 +417,7 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>  
>  static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  			  phys_addr_t phys, pgprot_t prot,
> -			  phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +			  pgtable_alloc_t pgtable_alloc,
>  			  int flags)
>  {
>  	int ret;
> @@ -467,7 +469,7 @@ static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  static int __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
>  				       unsigned long virt, phys_addr_t size,
>  				       pgprot_t prot,
> -				       phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +				       pgtable_alloc_t pgtable_alloc,
>  				       int flags)
>  {
>  	int ret;
> @@ -500,7 +502,7 @@ static int __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
>  static int __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>  				unsigned long virt, phys_addr_t size,
>  				pgprot_t prot,
> -				phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +				pgtable_alloc_t pgtable_alloc,
>  				int flags)
>  {
>  	int ret;
> @@ -516,7 +518,7 @@ static int __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>  static void early_create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>  				     unsigned long virt, phys_addr_t size,
>  				     pgprot_t prot,
> -				     phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> +				     pgtable_alloc_t pgtable_alloc,
>  				     int flags)
>  {
>  	int ret;

