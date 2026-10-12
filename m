Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A64396572
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Oct 2026 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826317; cv=fail; b=s4giDAU9AZu48vHncDHOgA8FwAZ6BenN52/mSvId2qrDF7xddBd7CUM1zAiHsv0c4qg5z6l/6Rt3yswn2A7n5f1PSt2FHhZId4IIE+D0OjoXhg4twjbiamPFhUCPkT8PJFAkULIVpXwVGnNsg/3FtqrvD4piHzsKtPbvhmNWeSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826317; c=relaxed/simple;
	bh=a6BoidNJXDNax5sz7N6Eh8M7Q95ZeGQDdkCEkNL1/j4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o5xMIbYDQQ0u89HNhaHdwMIke5jorCnULv3rzBxFs7RLz8RkXPgZ3tJWNhTKpbKrkqtoeIaBlYaIphx7rIXQeJQYZONwBhDh8mgKrrJ0Q/KQ6GvvlsiFT41ahzxC33rwo3FbxUf0RpUxz/YlRMadkSjZvkAoZbCQVmSroYvh+zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxVjnw2t; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxVjnw2t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791826315; x=1823362315;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a6BoidNJXDNax5sz7N6Eh8M7Q95ZeGQDdkCEkNL1/j4=;
  b=cxVjnw2twnxfrhgDVwB8gAAy/M9DX2e4EFG9qeUL89oe4tzonv1jlp4B
   HSGjQTzbVTJbDYaIeaDL262xs2O3EKk95x6W7rwU4b4NdZesOb3lZit39
   jq1nBew1ywW5JGT8Ah3JOOP23uyMJ+9NI9bn8dAY22QKg+8WbtJyj8Rsu
   h5BkOBPC4Agyl7BkoGD2oWRt/6/f2XScsaRK5p8uszlcBFdNX+HHE22bU
   EBnpl47hiZv4BcBmRnpfVi8aRDguNWyFlrxR9bv28a1rZz7enyumb6AFE
   2hIIMtLjyeUZYqDNkqyhsTeOWZ/nQoJTSx4OJcTFC9EJqsMA6iE0vfm5s
   Q==;
X-CSE-ConnectionGUID: PrwOCNs0TT6BUCuiEE5HJQ==
X-CSE-MsgGUID: tapVt6X6SbqCnLQMrMIEIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="566720"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="566720"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 10:31:54 -0700
X-CSE-ConnectionGUID: gKWIKN4PThqtQQzwORd74Q==
X-CSE-MsgGUID: 10H8mcF7Q3SWXF8ye+4D5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="859341"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 10:31:50 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 10:31:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 10:31:48 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 10:31:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNQtLbCecsUoDnVChkPdXK7GiBANsxnl0fGRkTh5vQChcVGrdyajpPkwsCaU6+j5XkY37UYwhvZsCftUBE4/qPaFWFApuC9hbOtA4L0JbEbq5xBo5Z0YGXrYUi73VVlmyOw50xu1EE5oRpQfRe5RggAgvhepeA3f0TYZnpeRUWD1cJ92VaY7i18E/z4IJA4F/NB2ev0twx73YleUETox6yqTC2x3S2DfywPxC8b7VgMf0zlYco6YHbpNlKOqHg5Cs7TmQhmiv9eNZ1CykYJ5qQUI37SZeg8WgjEbR2CJ3vFrbBdGhRv/P2rZLQ/sFM86dkiXc+ZQaGatYf4kQAEqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hd++Y4gVYeYpdrZGNd5YNVfWi6hI2lZvYBJyuES0mzk=;
 b=BAo5SJGbNkMjmxhMjvw5LhJjY9kGU9AeuBpL8Jd5AClCsCU8aKLykt6PscpSRLrwgYG3L9Dp6hDDGtzt6ONikfEnGJxj4HvnRuTJE6rLnM0bsUq5FN2KdiXcoI197RMkR5GKX7MkXbGcpIz0DFg6PHU5M5HUyVDXiG4DAh8cLQ9AxjkNbHU9hqqUtZJc/BhuCNJ5xHpTG+6q38orCmRs+ZO52lbdZSVBULMk4mQojPBHiuB4rZkKv2dsFCyiveLJCzOmOLDZpjEta9fTTDk5ZZPf2NX7yvRntMNeaqZiX1uEtQC4CU4xxxDqwjuSWMJZ/53fL1tuHUfWoh+MdZl48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA3PR11MB537784.namprd11.prod.outlook.com (2603:10b6:806:52d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 17:31:40 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%4]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 17:31:40 +0000
Date: Mon, 12 Oct 2026 10:31:38 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Drew Fustini <fustini@kernel.org>, Adrien Ricciardi
	<aricciardi@baylibre.com>, Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra
	<atishp@rivosinc.com>, Atish Patra <atish.patra@linux.dev>, Babu Moger
	<babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>, Borislav Petkov
	<bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>, Conor Dooley
	<conor.dooley@microchip.com>, Conor Dooley <conor+dt@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dave Martin <Dave.Martin@arm.com>, Fenghua Yu
	<fenghuay@nvidia.com>, Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai
	<gsh517@gmail.com>, <guo.wenjia23@zte.com.cn>, James Morse
	<james.morse@arm.com>, Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, <liu.qingtao2@zte.com.cn>, "Liu
 Zhiwei" <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Peter Newman <peternewman@google.com>, Radim
 =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, Rob Herring
	<robh@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Vasudevan Srinivasan
	<vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li
	<liwei1518@gmail.com>, yunhui cui <cuiyunhui@bytedance.com>, Zhanpeng Zhang
	<zhangzhanpeng.jasper@bytedance.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <x86@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 2/5] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
Message-ID: <as0Zeoyjiy5CW1DT@agluck-desk3>
References: <20260901-dfustini-atl-sc-cbqri-dt-v7-0-ca2935d85622@kernel.org>
 <20260901-dfustini-atl-sc-cbqri-dt-v7-2-ca2935d85622@kernel.org>
 <8230dae2-2cb0-4b46-8cec-dc4e281d4e4a@intel.com>
 <aqwN1szItGPg4Qjh@agluck-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aqwN1szItGPg4Qjh@agluck-desk3>
X-ClientProxiedBy: SJ2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a03:505::9) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|SA3PR11MB537784:EE_
X-MS-Office365-Filtering-Correlation-Id: d1fc6934-4d62-4fe4-5e5d-08df2886acd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|22082099003|18002099003|6133799003|261009223027099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: RqaEqjQqGYSZ8JZ0LzOXpRXrmlZgX3EKCU3tYYmRgyoPAmPDrdXJZKFDOvF3QQC5BQsngLu0jmXKMbYzuMp4HBC495X/T7GWvOi5NIQYFlnms935dOAebdYCpEuGG2uNmdcj6Xy44sXqHcjYnc26tDDEa02pXa51S1KyahLLbIOQfQN//VsAdN921xNC3oEGHDuPkBQv5wOn9+RKJsqlJRhLnesvN9FWA2GbGCMaQdIa2QLzfrcOfKOCZ7LBwee5KRVwEajtykoEMK2FCKob226P+Muu7/TX61BHqumIH6IcNsgGJwYz8JFQWYRp9n71fwqh0jYdrfBhO6jLcLkK92h6bI2SkLZ8QotCdYkQ1BUyNaP+4SvYO48TLYsK2QBmlRiQo+53Xgcq8ULXkRSy5r0T8NVfhFyVNERsRVkxKNc9AS1+ijqLYa1bX3IHy4XsuKzlOxLVKX+G0RDm4Bc104abO6JUFkEdt5MqkNZ9tOiFzmmved9Felqz/TYVO1mEMP6UjtIihYYSgTcZrLsrEjdGocuNJsPoSBX5OtvOB+sTFydoRcHEpbIIaVPxXNhfM8ahcdnN65YVLLXWkclg3gcT7NFfKZNsKf6XuD2qJQNjrq+zVNjnaRfiDd0Vp8Ou0AhqT6e8qkdM3qVTya0JiQFVKvY3vdh0dXnJiTbEt1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XcC9WohqzPWr1bOV+2JjSWHpKkPi0JVMN6lPfP5bfEbkGbeatMNmo4z5E3+N?=
 =?us-ascii?Q?ByL4JGp4RJm4iH0movHoMj0pz9TGYe3OpM1z08LOLDHy4+ZcJVmVKFdSEHDq?=
 =?us-ascii?Q?hciHaBnLT3Drrs+zH3FB/fvXnQnaPyUtbLguDUfEAkhc/5fXmDBErFELlVk6?=
 =?us-ascii?Q?8g2zQVSjv+ijfpZOmdrmj/IdamNPq+rh536+Bd0/eH4KNRquKxsFcPN+gbWf?=
 =?us-ascii?Q?bx3o985v0WF9JqVzk9C5HRwvp27nv1u29MXg7sVwU3eyD4C3uVxS9X8fRUPu?=
 =?us-ascii?Q?ggc/u4ww8oPq+3RsvUC7adLrzAqiTA84S2fjKtF+BSKaPduBC1MqAusYNHg7?=
 =?us-ascii?Q?Ronhb65bkmVAa8q0+K2FIvUPiwx8Mvs3cU/ZeFJWe+pkWDiCUCVHAeMKc/4o?=
 =?us-ascii?Q?adv9rty6IrfEbZULHhNo3+WLjSDGyo+3F/nrhXNRFeDABwdK3ro5dBpWnVWC?=
 =?us-ascii?Q?++jolTO7+lSGR2b+rIVdVIkm8KA6V8noZDndPafX2LVzZE19QZjIS+B5DupI?=
 =?us-ascii?Q?UJKppJWbwnd9m0papcLIuTWawtJwBF04IpI8mziD1tYcf1X5Z15Yr1yuDEXK?=
 =?us-ascii?Q?r5gUvXDGBte0af5bsjvZ6QldO+xmefg9HHeBdi07RbPdwL3v792ICZLDvxR7?=
 =?us-ascii?Q?SP/1+Uu8end5wzlzCA+YUB4sSOnozgZxMDQ/JoWahXsIcKbGrlRUe82kRP2Z?=
 =?us-ascii?Q?uxz1VRTL3EJb4GTAMReuCEAoIhBaGIDZhsg5ney0bquNFXUSzjedNvhv1rln?=
 =?us-ascii?Q?TEf89Uj0tmgs4uW7yY5VsG96pTxwZS7X7uRTpdJfRdsa0Pb0tXly4p1sIUf3?=
 =?us-ascii?Q?Nrqu8yhVH7jItcQHBsPBsaQbSmR3PRMD+hRB+GP8CzyeTTDe+dNEgf05Igo2?=
 =?us-ascii?Q?o+HEUHLpHXXCp5KhNxvbeBnCVlUAxdtwVZCAqLIpd2HKr0oDyKScoDv1hSw5?=
 =?us-ascii?Q?43chXmxM/WU0uuoyhB0KwbhAYMsSF6etqtwfPkI9tZIfGW82SB7ZHmQ5LBa4?=
 =?us-ascii?Q?ypyvyvEjyylSfZN7T05/h+N/h0XcmNKOFRHpsyps2rSagsYYsYtOrdanj1jH?=
 =?us-ascii?Q?Hhdlg5kNMfr9E79BbzWgyR8Tjzbuh+vdBKUy5zlSAihMs6EKXsYhbItJRaa8?=
 =?us-ascii?Q?SrOjJk3kY/XeEVJOFelchLggSWboT8Totc3XSBGqV630wW/heWPHXZEvDsqq?=
 =?us-ascii?Q?8JrJSDs/acuAgFcCScdIddw2U1w8sJSWoNKTG6ArrpI6WoiZnfmw5P/62ZKn?=
 =?us-ascii?Q?8vWb4ld41bNzA8Yvf8hcRNSqjs02NiBzrWGdA/tRh8WZ7HI/+JxzRFhky4bV?=
 =?us-ascii?Q?8aX/RjQiCJ+sT2ojxa+nUCvdLrG63yRcJrsDHTWj4zbE3EH/KEfFTFIwB4D0?=
 =?us-ascii?Q?j/GVxYyDsWtrtxZafyP8MxCWiUzY54TPqp/z118J7d1kSb8q4NAfMAyPDXku?=
 =?us-ascii?Q?faLG5qVYlgvxDH8sOjtq2cpEQkuDr24EjTxJQX8ehzvtTwWXUKmo7XnlFDsK?=
 =?us-ascii?Q?noPom4Iv4FISw6gbu9m7PQkjM9qKCwpFsnc3UpRZHTrchTtOJGLBA0mVnfwZ?=
 =?us-ascii?Q?VCZimOIvvB9JQVN4OyG/Tw/Mgugwh1VNnGjvPzd2yIebxw7FORzri9wMzn6P?=
 =?us-ascii?Q?XeKtiTY7Xx2PQSZRmXKWKrY0k6mc74dgU2uDjPdabfmYEP7KOya7q27oqYN4?=
 =?us-ascii?Q?VDAhE34m5cSHd0WOtoE7GeZBq2BPt/W+w1sqUTgHVO5WW6gyhrTOTwucukVC?=
 =?us-ascii?Q?ppSUnz7Lsw=3D=3D?=
X-Exchange-RoutingPolicyChecked: UQ4MktU3YEV89jnccXL2XnwrJqkaNNqru5ynfF2FqDEIhTh34iX1MeC2ND7tvtN60cDZ+dggvp50WTprW0bwZcW5wwJx44S9qqJFN9DFl3/VwBR62FNMgpdZjUvI42js/F6CkkWYn7wuT2Otr/XQnZrz8K74SBP74g2hki8MHycNPGpmTzNl+LFR0hcVqvOfkqJv/c7kGlqM3e5UnooLk7Ir2KoTG4HGOaaf3LmQ5fkqbTB5fdzTeUA3hXJA70pIaPnzzRC5RIIla44BhNKS18GqvACzNErZc8Me21Zx3k6BK7F9E47lq+MABD6Qmk6+aNd99JY8y06AFFG6TnrZ7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1fc6934-4d62-4fe4-5e5d-08df2886acd4
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 17:31:40.2370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNZkfRnhsqnKN6dl5rTtpAsKyFZzzykVJMPVtceWmUOoWipCGxjpwMNA2Q2PCG9Lx81IpBC9WJJSwHYwApGJ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB537784
X-OriginatorOrg: intel.com

On Thu, Sep 17, 2026 at 08:57:10AM -0700, Luck, Tony wrote:
> On Thu, Sep 17, 2026 at 08:37:43AM -0700, Reinette Chatre wrote:
> > Hi Drew,
> > 
> > On 9/1/26 3:31 PM, Drew Fustini wrote:
> > > resctrl exposes a single cap set per rid, so when more than one capacity
> > > controller backs a cache level they must agree on those caps. A level
> > > whose controllers disagree is left unexposed. Other levels are
> > > unaffected.
> > If I understand correctly, while attempting to translate to resctrl terms,
> > this means that a cache resource with several domains may support different
> > capacity masks in the domains?
> > 
> > I believe the "single cap set per rid" you refer to is
> > /sys/fs/resctrl/info/L3/cbm_mask and /sys/fs/resctrl/info/L2/cbm_mask that
> > exposes a single capacity bitmask representing the maximum allocation.
> > 
> > As you know, resctrl is in the process of changing the way in which schema
> > formats are described. The most recent PoC [1] added new bitmap description
> > files but it kept a single value "max" file to describe the highest allocation
> > possible for a bitmap schema.
> > 
> > To support asymmetrical cache instances it looks like changing the interface
> > to describe the maximum per domain (instead of one global value) could address
> > the gap?
> > 
> > For example, if there is a hypothetical system with two L2 cache instances, one
> > with a 0xFF max CBM and the other with a 0XF max CBM then resctrl could expose it
> > as:
> 
> That sounds like the not-at-all-hypothetical Intel hybrid client parts
> where P-core and E-core have different L2 masks.
> 
> > 
> > 	# cat /sys/fs/resctrl/info/L2/schemata/L2/max
> > 	0=ff;1=f
> > 
> > The schemata file currently and will continue to display the allocations per domain.
> > 
> > resctrl will need more changes to support different CBM per domain internally and
> > until then all these CBMs will be the same, but adding this change to user interface now
> > may set resctrl up to support these systems in the future?
> 
> I think Fenghua once worked on patches to support this. But I don't
> think they were every posted to LKML. One of the open issues at the time
> was how to handle the info/L2/cbm_mask file.

I took git://git.kernel.org/pub/scm/linux/kernel/git/reinette/linux.git
branch resctrl/controls_rfc_v2.4 and added some patches to support L2
per-domain cache allocation bitmasks. Seems to be working OK. I can
share the patches if anyone is interested, but they aren't even up to
RFC quality yet.

I do have some questions:

1) The repeated "L2" in the path seems awkward. The first is the
resource name, the second the control name. Makes sense for MBA where
there may be multiple control names. But for cache ... is there a better
name for the control than repeating the resource name?

2) Should the format of /sys/fs/resctrl/info/L2/schemata/L2/max depend
on whether the platform is asymmetric? Or just enumerate the per-domain
values even on symmetric systems? Likely easier for users to list all
domains.

3) What should happen to the legacy /sys/fs/resctrl/info/L2/cbm_mask?
Just hide it? I also considered renaming the resource to "L2A" to
avoid surprising legacy code.

-Tony
