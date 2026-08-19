Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F23CF208
	for <linux-rt-devel@lists.linux.dev>; Wed, 19 Aug 2026 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787165141; cv=fail; b=ecxuYSnEPYtZQGQtziZPCeJfOZNB6pDp+BUYiY63ZQkpRVxvWcsR3Q57i5DuArNfDP2aN68exB76bCUPOlqTgTMB7rlne3o6c2ZgDF9J560ufFi4XUiqliVrz2Id9YvVY0Wp7dpR1F2cE1zp/4aWrqn4+7pUAj/82KUs8f68bog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787165141; c=relaxed/simple;
	bh=5Bfs1NNmuyi42VlQvg+C8doV1U3M2j8vRMz5ATbezpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XvcDxRsIHM+ggwTSqyjNXPp8Z720i3OpZbGpNEwMoWQBnCuHS2llo/S1qM768ql3UE3mHIPTmXuiz/G4T7Ncf4wviApWQI5y1GCXzIJeRfJsznHkmwEVC1F+WbZZPrQt+sjRECAVdAvJbYs6X/At5kM0c1GVcPMJX3bmcphQM1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hBwusGeg; arc=fail smtp.client-ip=40.107.209.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hBwusGeg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1ecZQBXXmNr3Jp7HiURpsHMc+W3rTzfNvDEH83HMCa7i2roHG0hrJ8sfx87T8pQfP2o6CGw/bsBwIqKBthbzGd59cvhbMIf+guWJHGNQkIUSTOKT/I7Fea1DtnKuCtdTUFF7Gvk0o6KsQhPR1Q8T15hXzCze/nIlD4G2Y9Jvq1yx+AdVOh7f3osXos6YdqYWigWsg+FZadZPIDnYVJoLfn6t034N3a05m3YePwL6WEdM8QBAsbu4P2XE9lF3gYJqAvlvrta4o7AKNKUiLO+uyGdP7vvtXovvIPRFrqDqF5mD5FPT+E+uSdEeBDC21wn/O7dBrRJxG2mSWnF2rOw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNAwsGTm7kQuUf+keSm8dMdgHBnRoxbRpBCcgD2gv5o=;
 b=f9Ws+YY8H6L54WUz36xy7fFnDaD6dxA6ZIFyNZi0arQ2DrFWV+skpiUHBIxY18bmiWk8eYX6O+GgocE+JElLimMTvT3aKB4wV+FKMYL9uz9sq99nXAcJ1F0ZdYhQtT2TxRFX21nuTZnQ7TIVGIhVlwFWxfiEaFNhczVfcuRNVSfgpJROIjwTKyk5JCYrQ79ZVG/UEAsVlb/IeudhxMuqqY+WxUUmzR/JhDqT/b3jhfJtxJ3RpZ2VaQtwJ46EJw/GDUtR/RqEJeeeiT0+ULfX3gQ2uz5y6rqk9h7+/CRCe1NJB4I5FMVcZUXximKAHHkqYjn9ExhMJe+ugZJCYjncEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNAwsGTm7kQuUf+keSm8dMdgHBnRoxbRpBCcgD2gv5o=;
 b=hBwusGegZXAvbmAZvJeF/iarls8lF51/jk8y84Ko9mTbXSavLuR0Ev/oaOzbTUkKBqwPEKCVaJrG2tWfeeHLVvP8ejFYHSRcOGoeFnaGeAb12sX3pV/1ZeBj5bW3xaBepF/a6kOLmQ5PfQaIsilayDqNhPTz3MlMIII2CcLpecf2g8GRj+lkwMyXagA3ND7flQtbppa2KeXhrQ9hnq4NQvAqxtdcITzhBcP9jtpWnDDCuR2gSuDWQtr18tzJjikDU8A/gxPSEZvPsGhyFGI/IR3MFNz673lJ+vQYl6IvmJTXaQ4sCAhgR3Ru3COI1N2nGNxLH5eqfnZ3Lx+49c7ldg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 18:45:26 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 18:45:24 +0000
Date: Wed, 19 Aug 2026 14:45:23 -0400
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
Subject: Re: [PATCH RFC 3/3] net: stmmac: Migrate IRQ balancing to
 cpumask_local_spread()
Message-ID: <aoX5wglLYYtLcE5J@yury>
References: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
 <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-3-3f79a99cadaf@siemens.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-3-3f79a99cadaf@siemens.com>
X-ClientProxiedBy: MN0PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:208:530::28) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d9abbc-0ebc-412c-1851-08defe2207b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|3023799007|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Rc9ZWa/NfWe54L2cRxa1wpIlZk/m+E6mV2bWnHtrKldkEOoNqYBrKgECTljKdJYBUK7Pkh8wMd+/PjPoFipFk2Dpt7u5jePZuoJXBYVw+OiUp+dP92gyfSGD4BOv5t2y9qWNXmtYD9S6/qRXbc9jX3nSFPiMWV0JrkUMuBSzDGyLz2q2d/LzKBM84vQ07GkEeSvc35RNtU+il5n3YQYZNbsqoFcLXjnED8QllsykLU+2vnmjPKYH4BYBVwIN4pK8tbJwQR0W09oxmUIJX7huxXcURASs19/kQjBPVjLVzlSwkQT01j80th1c96JTuw719neBONMB924rsjBOK6/4d7vf7tQK5C6FMSsq1LORg6BzIEJQXbDN/E+VkHr7LPIllaDn1vDsQ3KSWoSCVQEHEZiT1GpTNcuo/WadHj1PZwt1nwDjOQVnCRmSWDvpf1rzBF/VagKw0ODdxhdgSc+h81oHuKln0XT11UsUcTFKRO/SB65NP+Ehfb+qqFqXd0DxEakPFGVZEKDjKcY9f1vbZKI32dWO4q0rjdZg4pm0WH0yaddTAqB8NuEzsBl3LUp0CJTz8jgrcRI8Q4Nxr5d1Dt6QV4tuH5hFb3QUVufIXIXyVpSBc9XdnHs2ux8lWFapniawLa8Xo3YeqkFqRt6RzGj6u7si4T6M02RI0ha3+po=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(3023799007)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Te4O5XO1M8qy6/l9+EvM7NlVRDXgdsfTLgtH9ik843+xiZ/tjKyKV1LXyI0h?=
 =?us-ascii?Q?0chTtv9P5XqRRm7xI9WgTX5UFcHPx7VvNM7ZKAmcnT7FgM3QFl5XMSLebm9J?=
 =?us-ascii?Q?lBiUDh1oZUcxe+YhX3CFpVqGUwtnKtAc293wi9C/b3Ua7+LCXJmaqaTyHvHy?=
 =?us-ascii?Q?BGtl5zD0Rk+xBvJm2fcXXVbunDqtASc5dobDMreKKkhtuoWCFlNLI6U+4TCC?=
 =?us-ascii?Q?NNIU5gId3/JYZfPH7K03EyVWNRxcnxqUlchHMyXwG4lN/EaiHH80+3SzEVKK?=
 =?us-ascii?Q?suDrc0s4gVMMmgq/+EzlM16jndxyNW1TLJd8kU9EmYDsYIR5YAD4/m6L+Q4v?=
 =?us-ascii?Q?Wxih0hevuA9wW398DX3COP+x5DR/zxWd0F8aI7MLsC451Rq+LY6IyXANHs/H?=
 =?us-ascii?Q?iTAYRD+5FWTLih/Y808mfb1Jz/uRQ2ffkrv9BKKTomujycucARb4CLMtaoop?=
 =?us-ascii?Q?5bTJoeHFaCMEhw1mW04GGhOxGO4vroZfAu2Y2yqWDtySDKEs7iCxeFQU0mZu?=
 =?us-ascii?Q?OYNHGOxnKz8uLC1hkjFjRPBlH5sWuGYkCAQwyaEQhoW4DZ9Qy/FU70eYGsko?=
 =?us-ascii?Q?fduModPBiditR5H+KT120roCbnKuB3wM2aqaNsF/597/WHXOQnKtzpcFsk3e?=
 =?us-ascii?Q?b2SjBMFJIYmJ9QJutC+HJl+u7nRcbIsWkuvNj5+LLLPtnBG02LhbNwWvbAQz?=
 =?us-ascii?Q?03D6RBVi387zQx8eJZ0SHurLABep6XKRwEBU+1AFjSGPH9uf1nT4pXMqaqnf?=
 =?us-ascii?Q?i7Q8sadXGJHlxAJ5uUMI3LwC+9aXQ5NSmCUiu0m54JuiaP6U4cOLYy4/v4/C?=
 =?us-ascii?Q?A70CAeIJvvaQ9hPjEhm4hnJ9KLWJtYj6Rl1ekD+SWlSed1U+2Aq4Wb/QMORT?=
 =?us-ascii?Q?+P2Aw2Jiosoa2TQ4MiN4E2B5wG52lO2ZYrErOJX53/6e6pzXvUai48CJn/QQ?=
 =?us-ascii?Q?v+uhkWg+NWtCeMerkGyvMzQXofJGULu/6tjN2XMeHfI0W+mDnmgFarSg+fSx?=
 =?us-ascii?Q?ayRFlQyDm1G4QoL/TCLn7pPhkBizVDBFeqEpLsQ29/Ec/DP0Vgo/nmBtkIDV?=
 =?us-ascii?Q?Mx7oNEwr5+wOHhcSd3Ovj0e1SVezzoVvMyEoWvrgQJtQUvyCAHS1CBK2YPnX?=
 =?us-ascii?Q?lEfkMC/AWlqRH4z4uDcpQua0FkNxvL/5gJ+Xb3xB9EvQqoEuwftVK6uMbPn7?=
 =?us-ascii?Q?bZXCVheY+kMhSadfIBhfx48ZfLw7mkk5peYsnfMSpkTCFTixNOz4mFdgZTyG?=
 =?us-ascii?Q?Ak+ll6kwXwER1uPLD5kYIJ8E2rtZ4Oc4iAniy8qnPQtmLc4okBm/drgaKHiu?=
 =?us-ascii?Q?YEshcxfy/Gda4IbDlQxlv/7656QGBJqa6o4a6Gj8dkv/3fl93f0rRvPvio5r?=
 =?us-ascii?Q?cf1PslH45SgbSzlci8gg9ykR6n0xyvHgwTW44nYEREtCRhha5x+UUtVA38Ey?=
 =?us-ascii?Q?HPUUmQndvNbGzQbrcABelMGY+kIplJ79eHYYfMYNrR3K0fzldzOWkmp6FWtA?=
 =?us-ascii?Q?XzZioKnR7wH1n4v0JxMyA4nqKPq8k3zUZY/njo/xzo/7VIQtGVS4I3/m+z6v?=
 =?us-ascii?Q?V58x4tSJO8pOoQAxbRmG35zUqcZPeIr7KSwpIkYfLrw7TTJZ7/F3aomtYbel?=
 =?us-ascii?Q?vAZKjEKa0HmZuCsQ1lNeATccAcKHfwz2RZlzPYCtD5i6FTrmdFo8KFGPqRWd?=
 =?us-ascii?Q?xt6hFeQRitW9wkcvLc6UpoFXCsbGF50RbLZXWeiz9jJuOnKl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d9abbc-0ebc-412c-1851-08defe2207b3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 18:45:24.6615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaKeZ3qt/Wy1s38wgGesPrrownXqaGxNvmVnXLZlqOGeyGOhGoh407YpuX7C+aRkj5wLgDeEAXPGQSRJSJrfFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071

On Wed, Aug 19, 2026 at 04:30:32PM +0200, Florian Bezdeka wrote:
> The previous balancing mechanism was based on num_online_cpus(), which
> is a problem for systems cpu-isolating workloads. IRQs were targeting
> CPUs that were isolated for those sensitive workloads.
> 
> With a migration to cpumask_local_spread() we
>     - get NUMA locality
>     - honor the default SMP affinity mask, which avoids targeting
>       isolated CPUs.
> 
> This also aligns with the pattern used by most network drivers dealing
> with IRQ affinities / affinity hints.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a71f0df263785dd8badc45292ca3067ab33bda05..949ced7e46d2814b57c6bd86b4886ac3bf33996c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3826,11 +3826,16 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	struct stmmac_msi *msi = priv->msi;
>  	enum request_irq_err irq_err;
> +	cpumask_var_t affinity;
>  	int irq_idx = 0;
>  	char *int_name;
> +	int node;
>  	int ret;
>  	int i;
>  
> +	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL))
> +		return -ENOMEM;
> +
>  	/* For common interrupt */
>  	int_name = msi->int_name_mac;
>  	sprintf(int_name, "%s:%s", dev->name, "mac");
> @@ -3916,6 +3921,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  	}
>  
>  	/* Request Rx MSI irq */
> +	node = dev_to_node(&priv->dev->dev);
>  	for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
>  		if (i >= MTL_MAX_RX_QUEUES)
>  			break;
> @@ -3935,8 +3941,10 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  			irq_idx = i;
>  			goto irq_error;
>  		}
> -		irq_set_affinity_hint(msi->rx_irq[i],
> -				      cpumask_of(i % num_online_cpus()));
> +
> +		cpumask_clear(affinity);
> +		cpumask_set_cpu(cpumask_local_spread(i, node), affinity);
> +		irq_set_affinity_and_hint(msi->rx_irq[i], affinity);

If you want to spread more than one IRQ, you'd better convert your
loop into for_each_numa_hop_mask(). That way you don't need to
introduce new function. See the comment on top of
cpumask_local_spread():

 * For those who wants to enumerate all CPUs based on their NUMA distances,
 * i.e. call this function in a loop, like:
 *
 * for (i = 0; i < num_online_cpus(); i++) {
 *      cpu = cpumask_local_spread(i, node);
 *      do_something(cpu);
 * }
 *
 * There's a better alternative based on for_each()-like iterators:
 *
 *      for_each_numa_hop_mask(mask, node) {
 *              for_each_cpu_andnot(cpu, mask, prev)
 *                      do_something(cpu);
 *              prev = mask;
 *      }

Thanks,
Yury

>  	}
>  
>  	/* Request Tx MSI irq */
> @@ -3959,13 +3967,18 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  			irq_idx = i;
>  			goto irq_error;
>  		}
> -		irq_set_affinity_hint(msi->tx_irq[i],
> -				      cpumask_of(i % num_online_cpus()));
> +
> +		cpumask_clear(affinity);
> +		cpumask_set_cpu(cpumask_local_spread(i, node), affinity);
> +		irq_set_affinity_and_hint(msi->tx_irq[i], affinity);
>  	}
>  
> +	free_cpumask_var(affinity);
> +
>  	return 0;
>  
>  irq_error:
> +	free_cpumask_var(affinity);
>  	stmmac_free_irq(dev, irq_err, irq_idx);
>  	return ret;
>  }
> 
> -- 
> 2.55.0
