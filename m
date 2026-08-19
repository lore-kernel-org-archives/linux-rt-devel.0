Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5068E3CEB8B
	for <linux-rt-devel@lists.linux.dev>; Wed, 19 Aug 2026 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164712; cv=fail; b=IrvDUH/FM8RZJP653H1NpNzwuzwo8cHMtLvv7DmmlscPniol7bF+y3frko/H9zt9n9zoKcP40MT63QvW8q7RmjySHp0496c2bznq2UfQAsRCuMs4+9cVZTaRID7QLBb9JUoeKK/qVtu5sx7D1JdHg8xMILBgp72q17cSc01oWFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164712; c=relaxed/simple;
	bh=dp/HEDvNE5cV8goQPRYsEL+fbmbG15sM+FrRa5/BgMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eJPLwwmCCu8kV4eG8b3+8tOgSTl3HDHqaWI1i2usvYTAJ966vNBnMTmZET3w/mnJE1mUvga6iTaaY5BJysvQK5sLuQYl4tW4xo8J28RFMIhrSyz5NYwDoOiohbiaaaJ8tOpkp2V5FubEtJOT85BAvrk5IhnrG1i01UMKv2Vq8dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TvnHhhKX; arc=fail smtp.client-ip=52.101.53.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TvnHhhKX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3CCnpy4/dIi4OCZFZuDMS+qD8j9k+Rir7CjvcOwfx7l2MGOR3crgyr4di7B9fPw6mhj8n2omB1U5hohdgEBOmOLCFErgkzLeINbsuckSIM8OKzgGTozRathwOUYLM7yKfbo6S3KfmScNg0Zj42Z73jXsE0XMB+wtIeqih/VVTR3K3t0+5jVe1BOyqBXDrKnXpNAx2iv0nz8yk4hcAupUc+dbOjxBQIGbq5vTdKmpOMA2EuTR67uuX+ZimMJrqINW8i3yXmZ3H6d9uIWFzdfuH6+CM+QmZ+SLowxchEz4BpuEt3zERjyXUbgVbJnJGOXiLydiIUPhuvdQ0exz6/sjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCsubKjOC4zF6FxrniHa2LF+4dOu++aq9oHsREwakNc=;
 b=JqMxMfcXIKDIZHgN/SNWHl5LuFveCziT1yfx2ZGl7MT+w/EzbTljZuy3yKk5COPiBt36FIgSDDjhIZ+aE007qlW3wGbWdndeafkRlmO2TZUnkaEOBzVNbAZQ8m9xsLgu3mRoeY8t5l2Oyt/sR/uNq/7FjEO7x23bCmJGKVB+cUUz+0E12jGd4EuYBiNbzMh8Vy9I59oylOWXlkO8DMtkA5enaeyITLgx4idoAwPNsXQZn+BL13dYKqmuMqvmFzLU9MPooZEk4Bw0Lt9tAx7llp4wV0MsJLhNN9V0EwXRpRWlBRmT5/B6B5CEpJTymr7/ZMN3Sj+8fN+9O5NSjbf/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCsubKjOC4zF6FxrniHa2LF+4dOu++aq9oHsREwakNc=;
 b=TvnHhhKXqeY+gFIpmROJJ295BWXduWsQqmrhr/3osbVUBtPjq93qkTHJq5J+lkpTywkBg5CVINiAKhdWRDM07frgTAjh1+G1HscGO/EQKE2qXDtzfFPALfDvjlbtuTJc7ceNGIo+gHf0/ows+uczFhq5XhMMs2/MVa38OM3Eej1daU88PrNxC5jYKz3syGXLjmMADZ9nchSB7VAMNlJDtlh2+FDvgQuU1a/l2UBDyWOgk+yHC/9IUud+X3R05NP/3I8n0N9RQXrM6Dg6ioFOhswjZOW4xtmiFYWVHHvHjITAaknIDvEFZSjfIXKMtR8hcGB7+Vc1zWCMLulkVV/6Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 18:38:24 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 18:38:24 +0000
Date: Wed, 19 Aug 2026 14:38:22 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH RFC 1/3] cpumask: Honor irq_default_affinity in
 cpumask_local_spread()
Message-ID: <aoX4HuUxL4tNWvpq@yury>
References: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
 <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-1-3f79a99cadaf@siemens.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-1-3f79a99cadaf@siemens.com>
X-ClientProxiedBy: BN9PR03CA0567.namprd03.prod.outlook.com
 (2603:10b6:408:138::32) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: fa87580b-3fb1-43bf-12e2-08defe210d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|3023799007|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3YEASpq9qPgFiZIKAwN+e+MtvbtjJxKTvac7pA85ovDSVKLMH7R7k/f3mAJOVpTbjjhEcxm9URx81kgrkiKnhAh+bYBk9V2C4z1E5k+xThODiujWD7eS6MPS9BEVAHH2z1lYmSFI0/qX6WkfKwS4M3ubwwSGwSiMBBVbZ2+SezOhL4c55mMVAQKA1bf5Yx9THakm1aDlNyNhNfyPZwWmBD+3DGNX4MU5yL16IVOqyRJCGItLgN2dDtvLjYA7S8Kbsyus/8Oh5sQJURlMXFFPc6LfGJLZaiN/gA+Pj+5XdTqHF3Lpf/UEKGYfYX6wFDXenvIsHbe8YKKXVFd9/RWz0qjVUn5bjuwfayh2YGWYcd6MKBlS/BQp05L0JH452/mDieSYMzDNF1yLnsCLXHzyY+hWwb8DjEIsmLWDIStvpzw5Rj882aJuGigNxXEe7Eam9Vuz8KyZlkgQ2/P1yI0OvWh3QXvHUXP8oAgdZziJ8GEQGEdIPwcXjHYRwh8Ug2hj0WcoWgoBTISRuQFFSAM0qYYq6fXafb+XGOMOt+hCC9UQ4ZBVGsT0vLUcjDPY5Dl3Oo3e2w+0LrOT+/pfDr+Yyj3mVZs7r70bFSGqGv6P8nopui1B1/2juL9xVLa+FeVayXI640+bVwYgePF4ePJaSZddy2eiJYyvgI8tn8oKZn0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(3023799007)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UWszE8FMVddmBY7Nl2jnI8fmNBmiRcC1NdSBz+YAoZ5ypTBXTO6rl8rHwKyw?=
 =?us-ascii?Q?I/Ol8oBLpMkT+/yvqX8nRtujkxR5sLBYkxr7J5RWyXt8cPEkla9iNE5ECn2s?=
 =?us-ascii?Q?c5YPtVKhrgDjCuK4ltKcC0/+hBd3/C+EQG3/YMumgQNzXlZmF+cg6ieyEw1U?=
 =?us-ascii?Q?2icXavhIw+wTTPpAwuJgY1waAKkkvcDqBjYcHhzhVibMNwZltuSEuD5F2fcN?=
 =?us-ascii?Q?G07j0g3kiBpC8h1+pBjkbz6tSnA1zwsUvaNhfB714R2MhMbHxhppHF2LYIYu?=
 =?us-ascii?Q?qxCiQmICNVk+/3Atrsl2R+8meHac8KyjfCZfI0bhsAXGJcI80Gz6LqNKRZm7?=
 =?us-ascii?Q?mrmBtAmQY05rmEYlDOXI7Y+drUQLY7yJVWMalnwmXrBxsv0EVYv14UMa+Dsc?=
 =?us-ascii?Q?EE4WyP9/05GKUDnRXmyWoIX25VU7ukY/8zxi/iclxfkLHgi/BA0QV8wtv0/e?=
 =?us-ascii?Q?M6meYgxlfk4DhcHeb/BDsFpY12+GyivPUJm/xJ6GYPvrKX3TgNDmUYW3yb3f?=
 =?us-ascii?Q?3C2oa6wVehfjBERFILsIC2rvP/E7autA29LyHbhcduk+yeb83Cjs2zLvkg8y?=
 =?us-ascii?Q?zo230/3rkWtIvqplTz7/jPxrV6J+n5bqdh5xxlZV4BnfljdkDMckBSnNKGIU?=
 =?us-ascii?Q?GP1Pu8h0NJSaQ043Qc0xGvpos7nlBMGELvVqXJrKBBgttLXekVkW/gRTpZY7?=
 =?us-ascii?Q?IP+cFJ11Lzt4tDo7BBU10nXXuB6Pk1Q7WLLmFukVO8w9vBmcAt1NsCVvKp5Q?=
 =?us-ascii?Q?QEFTO9lEom4hwElJzKmFbplTlBQ8kXbXnDwiihuELIoaYFm0Fob9puVYkrfS?=
 =?us-ascii?Q?5inEIJKZTls09kO5OrxuRYs3Ca+sUa4yeRfuy3vHbDuIR3o8qxsR8vQlhDIi?=
 =?us-ascii?Q?Fwp5PgqSugF2E//gVekMwVus5bDbMIFD0IAGu6LiBGg6jdpN+Cgsnp9mphBN?=
 =?us-ascii?Q?WB/AxV8g0hFuAYRzvhYEtj6gG31tSLKwoTdSVO46YszjuFDhHPKPTXgLk+8z?=
 =?us-ascii?Q?B6nvwhCuX9x5lAN00b6d5Sj2+ejRRY46GJwUxIZWFtMwBexYxQ20kdZkx6Va?=
 =?us-ascii?Q?7A9fNJEC3BrJSj3RAfM5QVgAbqs4votX//VRIFZ2cUXcvEZ2/hqIwEhh5Wbz?=
 =?us-ascii?Q?b39cRwNpNqamAHWwrgUyX76SomJGjhvSnk2Gx8VeXrq/dM7+9ywS/wjZ4HD7?=
 =?us-ascii?Q?wDuj/paQYUk6nVM5d1qJRLw5SvbZB4lXKPLDEodWd5mMxoLs+yzHIreA1rfe?=
 =?us-ascii?Q?E/COAGyHNcgolR3BZI0w3zYr6w3/dbSBQpQY/9beOjwJUpRWGnNnbq+n+zmN?=
 =?us-ascii?Q?uTxQZIAogJnbh9m07Or0r4VR5B7W3jOI9K6ThFNEun+/l/UELOE2pZ9KNIjH?=
 =?us-ascii?Q?PDm/JKvTGuwgHYhNc3mIRP8AXD7yLUJMU0CYiMx7q3JDqPjLJFyW7MMrBJUc?=
 =?us-ascii?Q?Jj2EbhJt4jH1dUg3BhY6KZuW6yj0Atme731+311Zb5iOgQr4+c266+AG066E?=
 =?us-ascii?Q?gXQ2h0j1jgl4NVxsK25Ef8uZpiQSTkv/joOCh0acilvCn4VDwQgP43AdzoOJ?=
 =?us-ascii?Q?5yvcNQGp2CbItX3pW9WzV1bOu7DVoLlhEl+vlAHH+tPzt4MrwtTpcI9u9fQw?=
 =?us-ascii?Q?XG6HFJmCATcp5VxVckZoyHYNF8fj9TBvdrTqICGeeJakjRVVFdlG5yWEmc4p?=
 =?us-ascii?Q?S1IEY5ZItXjpHlnjuVrLyviN74FUsYppMN/aJGuDEFLdKCJ4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa87580b-3fb1-43bf-12e2-08defe210d58
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 18:38:24.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Nw4XXZG5P2zlwS6xTS8iqFGhemDs9yOqcfODjVBId73lmW8fYpDsn2V3MScptCWSqnbfe0Fbq4EmZCsiuJg+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399

On Wed, Aug 19, 2026 at 04:30:30PM +0200, Florian Bezdeka wrote:
> Many drivers call cpumask_local_spread() to spread IRQs to several
> CPUs, mainly to get best performance and balance CPU load. For
> realtime (PREEMPT_RT) and other cpu-isolating workloads the old
> implementation was triggering an IRQ placement problem. IRQs were
> targeting CPUs that were isolated for those sensitive workloads.
> 
> Userland will tell the kernel about the desired IRQ configuration
> for new interrupts by writing a proper cpumask to
> /proc/irq/default_smp_affinity. This cpu mask has to be honored to
> avoid IRQ noise on isolated cores.
> 
> The default for irq_default_affinity is "all CPUs". So all CPUs will
> be taken into account for spreading when userland did not configure
> something special.
> ---
>  lib/cpumask.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index 5adb9874fbd0f5a42ea8cd9e6c3729a70599781f..73e7b60a9201174f83df6067effbe7d1889dcdb9 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -6,6 +6,7 @@
>  #include <linux/export.h>
>  #include <linux/memblock.h>
>  #include <linux/numa.h>
> +#include <linux/interrupt.h>
>  
>  /* These are not inline because of header tangles. */
>  #ifdef CONFIG_CPUMASK_OFFSTACK
> @@ -81,8 +82,9 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
>   * @i: index number
>   * @node: local numa_node
>   *
> - * Return: online CPU according to a numa aware policy; local cpus are returned
> - * first, followed by non-local ones, then it wraps around.
> + * Return: online CPU according to the default IRQ affinity and a numa aware
> + * policy; local cpus are returned first, followed by non-local ones, then it
> + * wraps around.
>   *
>   * For those who wants to enumerate all CPUs based on their NUMA distances,
>   * i.e. call this function in a loop, like:
> @@ -110,9 +112,9 @@ unsigned int cpumask_local_spread(unsigned int i, int node)

Please don't touch this function. There's ~40 users, and we don't want
to inspect every caller for their intention.

Looking at ionic_get_preferred_cpu(), the cpumask_local_spread() is
used there as a fallback for the affinity IRQ search:

 static int ionic_get_preferred_cpu(struct ionic *ionic,
                                    struct ionic_intr_info *intr)
 {
         int cpu;
 
         cpu = cpumask_first_and(*intr->affinity_mask, cpu_online_mask);
         if (cpu >= nr_cpu_ids)
                 cpu = cpumask_local_spread(0, dev_to_node(ionic->dev));
 
         return cpu;
 }

Your change may affect the logic, seemingly.

Instead, please create something like:

        unsigned int cpumask_spread(struct cpumask cpus,
                                    unsigned int i, int node);

Thanks,
Yury

>  	unsigned int cpu;
>  
>  	/* Wrap: we always want a cpu. */
> -	i %= num_online_cpus();
> +	i %= cpumask_weight(irq_default_affinity);
>  
> -	cpu = sched_numa_find_nth_cpu(cpu_online_mask, i, node);
> +	cpu = sched_numa_find_nth_cpu(irq_default_affinity, i, node);
>  
>  	WARN_ON(cpu >= nr_cpu_ids);
>  	return cpu;
> 
> -- 
> 2.55.0
