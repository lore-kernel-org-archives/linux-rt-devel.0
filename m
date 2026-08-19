Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B17844063D
	for <linux-rt-devel@lists.linux.dev>; Wed, 19 Aug 2026 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164126; cv=fail; b=uaGLO2PkUljrLJGnmLx80mI+Jb+i/zeAvwhcTNNllFtdeC7dks3dEgKnTSkbyk5qPyttgpnKzN7mPuLGauCkCU0WmhfvoxPpAENTytpAw9M/AfBe2b/vMWorDMuaBzsLG4myGdeEP8DmEKSimkXIpNyXr0plrluDKYt9t6CS8Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164126; c=relaxed/simple;
	bh=K1ZqBFuxmDexvViMU4/HldPaGmaRuHo1utdwGbc95S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j3mXicPFIGuvIl4dxA/aBXUe2BxtrPLamV4LE13NvFZacI/RSE3/+J59KTsIbu+qYCes+uLobtmTaCfmaIC95IgZqo2ILxH7YQdUDoBO/uu3zQszsiwV3DDtxg3VPPi3Ckmvd9hZB4ArvzFgkPfy9uK7ORTiSx6jVN0DSKN5KX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C0tH1kHb; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C0tH1kHb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxqrHUuwvxIgt/ggeeamoPtmbnM87xpCGjGhXB6uchnCnX06hQvWWK0nSYlYwofN8WlL44C6B9t9oKFs164dziVOmA49XBiUF0n8f+Huu1ZBGKbeKqim5o/vO+wwaxFnfZpXn6p5lxktI1W6W3cni4iO3dn4q0jyzh2NnyrbKU6tUqz9UjfwsuVkQ5zuKEi5WcsiDGtRtyqRA0k17sUcYezxI4Di9XIDz+0wqg8ETl0Q2mRHieRp4F5OhlqYzaFGeQbG+VpIq0SpGoX5MKQjgRH5NDLrCGoS6+zdQfHBB2/rbKptunRkcNJK9LsA2YzpfqOIC20e9TFzo8dq51sCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YXIxdBnA3YgMEEVyRszEkQfRiNotik4xshcNBcccY8=;
 b=oFzdh5m1sCBKiLhar8CDl9ngovOpw/DRGMn+dB/yXERdZc4JKZp7/1RHnKkd2IzlPFjNOJ5XXzwhAhE4uOmYKq1n+cHaPbIXAjncweJA+b/awawYZD90iHBsQcoGSdtM7qJDNxb3B3HzDluP7D+8oa0mRSWfy3yHH+MGViBHLyQpTsM5ID23UA4Lx0LfX+2VC5Zhl27Gbce5/47zg5vYa92psBoZwnJxsp3mpyuHkGRft67Pl5Qte4+H2FBZopsYop5DmMJQcGTghE8I1P6G8UFCpKvHEMJ7sLOE8WrL0OeP1k2fMZRcbhjYdfyFUVIGtwnDKQhXHUGPgnEDhDjqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YXIxdBnA3YgMEEVyRszEkQfRiNotik4xshcNBcccY8=;
 b=C0tH1kHbn9Gl9nJB4GQNB9dfD/VGpq9Kp03zAjIPDPD9ylnmcc2BdZ9C2pRXn5c3IVWApXQNTODTgvoiuvaa+gDdYLYvZfmkbI96mb3crtErSN1X9qWQDQIx2r08FeVxE/e13Qmtgbe9zWrZIVCqSq6x66URSIQNn2wQdxNfJpyeF4/Eh4j6duofRkF5JwhRjsQO2B2zX7Hi8e/+sFW61Yspeehyjx24aUmhNqrDofm/AvxjcS9XZ47fAZHGasc58R/8/UemfN4KR9wt4WRbQeWfTsBEYKpXCcpboYDM2YQ4V35u4nNE6n8bCFqQ8l57nmAaFpXWyhWH29T62sTKKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by CH3PR12MB9023.namprd12.prod.outlook.com (2603:10b6:610:17b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 18:28:33 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 18:28:33 +0000
Date: Wed, 19 Aug 2026 14:28:30 -0400
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
Subject: Re: [PATCH RFC 0/3] genirq: Allow drivers to respect userspace IRQ
 affinities
Message-ID: <aoX1zplzjXJl6lOV@yury>
References: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
X-ClientProxiedBy: MN2PR16CA0056.namprd16.prod.outlook.com
 (2603:10b6:208:234::25) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|CH3PR12MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: 620b488e-aeee-46d5-ff75-08defe1facd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	AnKUi4oUOgiDm0JU52aoSxoGGxnbJmRJ9QEagl/xnGmCMSSph3flhF1jI0PPo0B3F7Gjkz9o6hyquyMvPSETV5AqhbSL7mVTcIjVFKpybduJ6Wdobs0U7TxUDRh9Ftzo5jFQZKGMScWPrRjcMRmUPE//EAaz7ASIR5DKMTh3ilU8prDZUO3pV75eDFtAHi7UYI352azN0wcp7mk56QL4srD/eb3XgILKyfwLtw6hXpozBWDgpOVjacVio6HFFbEXg6Z8WdhliqrXKxyRyYrtLe7WoRGPC1Dt5saOYOnDRwmGboGAKmrAiuxg1kMSvE07l3yrfuyVo2N5aB9lTSCCKbEPObIAriTwNs2witm4491htS+uc+UuAHri3hhshrs/d6vl9AYOSR/NIgopVJ9EZDUhM/2w1nc3rv5LOBhXdTQlrMua3DK2vjWHAYz+oQSdK6FdaUsYAN8Sz39ztFjEA7rXr8DtBoj6r1zRvYWc0cViaP43MvZo4hIgFLY0TbAH3fBGR6Mufy2O4tPL8pVmCH6ZFkNpJdiY5hXAKuBtS7e7z+iI7eAB9Mn18HWe5RZWbpEuhhlua3diWCA5+71uL1Y+HH2Cso99Hw+D3nllvq5/jDMwq30LOaU6XOZ21o/NS9s6MtITt8ZYLiALGYybIdgHZ61TJzAwLZRyFuyCqks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4IiPB9dG6yXcSTZbCYosHZ5LdJB/Nj5jkZWX24M2QujksYevjs+HoLqsiLD1?=
 =?us-ascii?Q?Yjs3Z9hrVAAYwW+toiTPJHSAPhSUVz/EpyuB9yuws9/xLE1W02DIGmoNVuLt?=
 =?us-ascii?Q?oOOV9CaNKEesKavFtrSfRrJI/ZLdIFFE6TAnJGmNutvGECVaBdCINuUasYd7?=
 =?us-ascii?Q?Rezv7v2LS7FKlQ2g1V0QIywdLd3XfHOHzIvjrjIfyrRk8NF3pg1As98HWyk6?=
 =?us-ascii?Q?TEZ1eXyrezNA96FNQ98emX8cBqRkmnALJqFTgEa3RJBlSLfpKb7pb0OPrXQO?=
 =?us-ascii?Q?rbpAA7bApPYK2SI9cEBPHlAkXYaGp/Q9aiLk21wVaYf/BnXGb324MAXhiIHN?=
 =?us-ascii?Q?Bh3qG8zGLlVj85ljUfjKyA4EzIHtnWrlRLfGkEyVPoPXQq0e6CLeZbndHoIR?=
 =?us-ascii?Q?lENw+Kkncwf6YZ6OrrvCx76b2IS3ubp3RU2dsD1Us+/EcNu8YIoRnZjnnTcZ?=
 =?us-ascii?Q?pMbl0MU6w2LH7pBGlDTsuYhZ5mjEI9oe6tSuTuK6axfThi+URg9MzvQM1Zw+?=
 =?us-ascii?Q?KTId71OEwmZoynXSrg6jzUFzuxRK1U1v343q6cGOk+IqonGmZ1vxkmrAFWOV?=
 =?us-ascii?Q?ycDXKMcQdqXK0+54CKec3kt7REWmlRKXKsnUPpQlGbXEjSl92f9ecVatsdBp?=
 =?us-ascii?Q?7pzMPx/V/VS6nP5vq0rlodHCxP0YZRbzZ/iAsv34QUKDtBf6TJAsxbQOAgy2?=
 =?us-ascii?Q?g5/83XV/JNO8VGOSYhmGWyehSg2kreU/E5yRAkwtq2Vx7kPPxxzZcEnbEJvl?=
 =?us-ascii?Q?a8yCOQA8Er62z5KUyKS2d0D1tZQkDiYjRW1XnzvWVpgmssxhcdy6yuanr+31?=
 =?us-ascii?Q?LeQiI6c2xvRWiveC9jcHF9kZIQfGob5P2BZB3yMUyDim1JCuRTPFbmUReQs4?=
 =?us-ascii?Q?P+pzFe7MjPXJfXZ4aK61BjyvbbYbuIFmVbXgyIEdGqP6bHUIHjT0A1WbuPNj?=
 =?us-ascii?Q?DDgPoXDugQgKIZRhDB0sPCyG8Qia9ZjsPVwPSe2GMN0XNaAUPxrfErZ+m6rW?=
 =?us-ascii?Q?JhkRnLsLWsGGGUrVGEVeLRC7qsChlO/2xBUfE3yuTTsebxgDWjMD4xc7ASBU?=
 =?us-ascii?Q?9sZQNrF5gWvG7QB46v2ZtPAvdYJt1bp5NdRQ28J7Y3LtsX7zSOVCYpyTKpqk?=
 =?us-ascii?Q?12O6rKq73rkU43OP/yeRCJqg9m7Dw6e3Aes5OluLIergS8ijteG8hR3WN0nW?=
 =?us-ascii?Q?kb4B45f4ewbga+BbDdxEG0+E1OJmDW5Pl/1aNj4/vcGeSx1qcPAK0T4xmUX0?=
 =?us-ascii?Q?GMXaUZpXPbhkwJeShUs0INMeysxdvQKR6bl19wtFBhaHnVhNiUohKcFAGtgT?=
 =?us-ascii?Q?aMnzKaVBI5mrGZgBbg7r2Rh2Pwf8j+Rn6XUKwT310qna8GvhP+tIpTKla7p6?=
 =?us-ascii?Q?7FXQqDYC/b0PIZUJrIM6yyrsPTc6DhG0PKpRdKZUYBiV6IfIX1RdReao/Auh?=
 =?us-ascii?Q?cGKj/WFv20yKmDAcs50bmuOPAQb2dtgNHAXs4Hy5k8cxvf5yQ+/ZLbOtDccq?=
 =?us-ascii?Q?3T809+4pOmaL9FtRu+asqflfpfgoBt4ITYzZyNDFRtt+2tRLrp75W7usMgWP?=
 =?us-ascii?Q?cewhM57P1AT9f6MRoXi1oImh+yF206FjFpsau7yJiinbEFqPdt7Zh39Nuv1h?=
 =?us-ascii?Q?cdtExZ/F8Q5fmvZ+XAaG35XPGDfCgg7XCbqU4eCweOTjSoXxmY9WY7lnAqyp?=
 =?us-ascii?Q?C8zEViHwJQOZ/05DrJUWmaIjFEdnb3YANl0Kn7Au9J6xklWr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620b488e-aeee-46d5-ff75-08defe1facd9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 18:28:33.3600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 703H7OfmBA+04ew6XaLMRvIBo2xKQSNmmTC+LyqKthzWIaZ5seerzuD9QwOlN2L4zv+3BWEuhCJFS+lHuSoMCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9023

On Wed, Aug 19, 2026 at 04:30:29PM +0200, Florian Bezdeka wrote:
> Hi all,
> 
> I'm trying to demonstrate a real problem for PREEMPT_RT here, using the
> stmmac driver as example. There are more drivers "affected" but let's
> ignore that for one moment. Let's discuss the underlying problem first.
> 
> To achieve the best throughput most network devices are based on
> multiple queues. Each queue (pair) is equipped with one device IRQ. To
> reach the maximum throughput, spreading / balancing them between all the
> available CPUs makes sense.
> 
> While some IRQ chips - and with that some architectures - implement the
> necessary spreading (or balancing) at IRQ chip level others don't do that.
> If a device driver wants to make sure that balancing happens as intended
> it has to implement that on his own (again).
> 
> The typical shortcoming of those implementations: They do not honor RT
> relevant settings like the smp_default_affinity or isolated CPU cores.
> Device IRQs are balanced over "all" or "all online CPUs".
> 
> That's not a problem for "normal" systems, but for RT systems - or
> systems running cpu-isolating workloads - it is.
> 
> IRQ affinities can be controlled via /proc/irq/<n>/smp_affinity{_list}
> for existing IRQs and via /proc/irq/default_smp_affinity for "new" or 
> "not yet registered" IRQs. Those settings - as written by user space - 
> must be honored. Always.
> 
> In our case the settings were bypassed by the following sequence:
> 
>     - system boot (all CPUs available, no isolation yet)
>     - deployment of the first RT application
>         - writing a new default smp affinity (remove RT isolated cores)
>         - migrating away all that were targeting the now isolated cores
>         - creating a cgroup with RT cores as the only usable cores
>     - RT application running fine for some time
>     - stmmac network interface went up for the first time
>         - driver balances IRQs over all CPUs, ignoring the existing
> 	  affinities
>     - Too much IRQ traffic on RT cores
> 
> Even with series applied there is (at least) one problem remaining:
> 
> The /proc/irq/<n> interface is populated on the first request_irq() call. 
> That means that we can not control affinities from userspace until the 
> IRQ gets requested.
> 
> The problem for network interfaces: We have to bring up the interfaces
> once, to be able to control such affinities.
> 
> That raises the question why request_irq() is called on "link up" time,
> while the low level vector allocation takes place during device probing.
> At least that seems to be the common pattern. Can someone tell me why
> this is done this way? Shouldn't we call request_irq() at the same time?
> 
> So, let's hope that all of this was short enough that somebody reads it

I did!

> and precise enough to make the problem clear. The idea behind this series
> is not fixing or applying the series as is. I'm expecting a discussion
> first. So, input welcome!

Not sure I understand the full scope, but it's not because of your
description. And I want to learn more about the RT business. I'll
comment the cpumasks part, and please keep me in CC.

Thanks,
Yury

> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (3):
>       cpumask: Honor irq_default_affinity in cpumask_local_spread()
>       genirq: Honor existing IRQ affinities when setting affinity hints
>       net: stmmac: Migrate IRQ balancing to cpumask_local_spread()
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 21 +++++++++++++++++----
>  kernel/irq/manage.c                               | 10 ++++++++++
>  lib/cpumask.c                                     | 10 ++++++----
>  3 files changed, 33 insertions(+), 8 deletions(-)
> ---
> base-commit: aa2e13ae8d3cbe2c15ef4f7e971b2de0832794aa
> change-id: 20260810-flo-net-7-2-make-stmmac-default-affinity-aware-a145a4941d8f
> 
> Best regards,
> -- 
> Florian Bezdeka <florian.bezdeka@siemens.com>
