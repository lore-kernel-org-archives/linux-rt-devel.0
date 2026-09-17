Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5553A4DDB21
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Sep 2026 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659493; cv=fail; b=NF41Qsg2iMt/7d5lnCx2p2ZE+NIEbWjtwAwhZ8uXLUAOpXg9zi/dKSJG7YvCoHmOsg/H18/CR7yla+XEJt/aPYxAj0LObFNeh0ORE/IRYdyiWQMyKq76tnkWR2wj2n8j/lFJejHxU2RuxmW6i26ZSFkF+cyrntXM2HXlI+iRc8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659493; c=relaxed/simple;
	bh=M0L6NhlPed5B+lXS7qti+BrUl0GGOUCAHHUjcxmKa0s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XBQF1JKSagPnx2deTRiC46vjepr65emi43gIp3PRnEfOMG+mdNgUXCK+TVp3+e6ohnfXS1N3mYFe7+dna7TBrBkeSKNMCvKXvWeBOFv+8W+c+FIo8VtTw3rz+gigRfqu7OdB/cV5DCpK/0oB+pS7t4WBUJN+ggEUh+HngoaU/iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lpgeo9Zx; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lpgeo9Zx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789659487; x=1821195487;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M0L6NhlPed5B+lXS7qti+BrUl0GGOUCAHHUjcxmKa0s=;
  b=Lpgeo9Zxlfxu4+OsBcFMcdtQG+vVvccNh6yEgFgGfPjY/3Ly3J19FkoP
   IkUUiW++LobxcnXABVJ49QYVEK5TUt4AlOsj0aC62E5yvpp2jUid1dPNp
   I/FmWJpoDveqNbfpQpSZBYc/OCxPQp2rpPdf8fe7eeGwDEQ9LsNzlJ9jZ
   ZOq4aPXAupfKsk87o3RROgnuj+KL57WV1/Azvr4MYbNc+fI+EmLQQ6sjI
   T+hv2/J+dGncTG2rRtAUPrL9jRBy34SYpxs1Fxm2clqlT/mWpWZJFXRNc
   99doSrvsucEjIuaD3do+NU/pFEkuy6YNFjU+6MpB+B4zwlo5O/nNCZDOP
   Q==;
X-CSE-ConnectionGUID: K6XKXmyTSwCxc+HCyACGTQ==
X-CSE-MsgGUID: vuCDTXUJS42ZnHB4+1PtOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90113730"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90113730"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 08:38:01 -0700
X-CSE-ConnectionGUID: l3PpzXNeRD+nsAgrcug3HQ==
X-CSE-MsgGUID: Pv1BuW1oS3qW3arx/golxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2297943"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 08:37:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 08:37:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 08:37:59 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 08:37:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNrgofp0dPq3JCFkL++tiOZIQ6BgyMHR6tqUteNbYyUmH0ymlJ2U9F5rSdIKDZ2UR1Vxz/CSNCHAp5odOXkk67xwUoJ+Q9kpix6zOUPTkZKbyiqZhIy0vpK1NG5tTva/hetW5PFZ47ZjfBv4z85HQ7pHdZJqyKh0iGWxg8b/eOScM3l8hWHxuoRdpZZlRWBYBc6lEW8fMwrhyH71u4+nxWosZUtp9sZpLttf+iCLJHL3BX51aoNh6/DBtZw/H3T96gNWN9vFzLd7227j5v+WCfRiH4V2l97eRAV723H1SwY8CYvZhf6yOvkR/A01b+JMqBsiuUqjsEbZ0E+KvOGn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIIQlPteX91Ad72+iib8dalFF0aBot5esUNfxDf9qs8=;
 b=IfbXUP3wzLm4Z24/UxrGqZgfGlMQSp9fdgPfSIqCQWocKRQ50vy/trRdb1BL0QqEfwNoqUM5eE1c1La3rTT/Tyyo3xW/HDvsTkXG8EPmgMKVvSXK5NK4GmxOIImKzEHy8F27JN204i/NiXHPhfYWtsYM/H8VaQzbopPKQiJdCsntGvIC11tFozLGsfocnQVYIWXmmrWySAroqL0GNbLd7cRaJCx+vTWy5AML3U0zHTpxhD/fUQcTLfVc4Cls6msXz7wud72fCXHqcoiTf6mettiNOxRUonnxJ54KutMvsVaR9/TnjxkYh0N6YIQyyabYsDxYkAbgEc7XExmvAJGqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by SJ2PR11MB7502.namprd11.prod.outlook.com (2603:10b6:a03:4d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 15:37:47 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 15:37:47 +0000
Message-ID: <8230dae2-2cb0-4b46-8cec-dc4e281d4e4a@intel.com>
Date: Thu, 17 Sep 2026 08:37:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
To: Drew Fustini <fustini@kernel.org>, Adrien Ricciardi
	<aricciardi@baylibre.com>, Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra
	<atishp@rivosinc.com>, Atish Patra <atish.patra@linux.dev>, Babu Moger
	<babu.moger@amd.com>, Ben Horgan <ben.horgan@arm.com>, Borislav Petkov
	<bp@alien8.de>, Chen Pei <cp0613@linux.alibaba.com>, Conor Dooley
	<conor.dooley@microchip.com>, Conor Dooley <conor+dt@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dave Martin <Dave.Martin@arm.com>, Fenghua Yu
	<fenghuay@nvidia.com>, Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai
	<gsh517@gmail.com>, <guo.wenjia23@zte.com.cn>, James Morse
	<james.morse@arm.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, <liu.qingtao2@zte.com.cn>, "Liu
 Zhiwei" <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Peter Newman <peternewman@google.com>,
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, Rob Herring
	<robh@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Tony Luck <tony.luck@intel.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>,
	Weiwei Li <liwei1518@gmail.com>, yunhui cui <cuiyunhui@bytedance.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
CC: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<x86@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-rt-devel@lists.linux.dev>, <linux-doc@vger.kernel.org>
References: <20260901-dfustini-atl-sc-cbqri-dt-v7-0-ca2935d85622@kernel.org>
 <20260901-dfustini-atl-sc-cbqri-dt-v7-2-ca2935d85622@kernel.org>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20260901-dfustini-atl-sc-cbqri-dt-v7-2-ca2935d85622@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:303:b7::30) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|SJ2PR11MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 434bbff8-eec6-4737-7064-08df14d19fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|921020|4143699003|56012099006|10067099003|11063799006|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: n9hBf8W+S0IIJ3eDJVJ4h0Uh31aBGV0cFuw0UbKmhyNCRDfR5SqpNA3nafcWu+bIxJmNInWzsYdlRAawwOXssL6Y+NO5kXBNwa5Cydyme31MdSb33a8LYs+X+aicGbc177wv9lwf76oTAAikcr30AUMHzv/OYtKV6oCKpXWV08ACOPNf6MEdODP5ecfv1CKrDtfKKB3tl6q1L75lMoKhFkOHwovb2QyqPK4Abi44QbKBoxv9xAeI0dKZzl/88KvPClWRPJL0rspHGgWWzUTyJhitYFisLy6ANV1bEmai4vFvwzC9kIU2YsPVEZNS4WEmN5dkP+syuJ7pAE7CbZ2MfMOcMLGvg3G6tQKKNESvP/tNsMMVm/IWR4q432Y+ivm9Im15+qIK1G9QYim3Vtv/utQmVyo/7ysJB+DV7bJavOy4ftpMqR7ii1zvthPkhoe/ioyM8gsTjCjLPYV2Sz3oT0OMnPHY0YXkJspuvHtiU0vKrzWrf97NbxiPTI0qonAUg/2hIJX/XvpgsvqDePr8ikPDqjO60CT917r/VfwehFegCxMS20QYwwapnULJE/dj+wQPbdJBGUUG8hVIICDISn6Fkpceqscqok+1o2XYzU6XwbRooSy2gex/nRvn43fdCWeeKl/pB11eBt1CNujyWYQ+iBXMLhtL/gayl6M1vKxdCdvjI8IKhMZS2E7/PZL3GlRZa7iV4gqaINdTxNyJ6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(921020)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1pQdDNGZWcyMWZlMElYdVZmRkhkTGNodkVCVlRacUZZMkR4QzFIdGU4R2lG?=
 =?utf-8?B?dndkTWN1aVZ0dFp2NmJGOUk2SmpEd0dxenk1MXhxbGM2dWMxSVAyWkhabmRB?=
 =?utf-8?B?OGF3SFU5OGZKZzlrNHlOMXRhRnBvTk5obDVrYTBqWDFFUTNYeU1PQ2FPZkNs?=
 =?utf-8?B?c25pZFl6a2Z5Ri9YdXkwQmN1Z3cwWTdYZnJwdTgvSnkxU0ZncWdsa1BkOGpU?=
 =?utf-8?B?cWFzZCtyNncxYzA2OGNpdFpwSGwySm1EVlFEc1haazZJeFB3UDZxUXRiSk5V?=
 =?utf-8?B?RG1wODFlbVFNSUxML3piM0VBbGF3QnkzbVNiVlFINTZuM2NYTHdvOEZPVnZX?=
 =?utf-8?B?VnRORUdCQXpmQTF6Z2pFNzhleitWY3NZeEUyZDhiNGxOOGtuVGx1ZjZ2UXpo?=
 =?utf-8?B?elo0L2RhODQzUkxOd0NMTkl4b2FyZHNxQlVKQjZZMnZaam5tSzQ3WWRBVHhq?=
 =?utf-8?B?MHdhSmRlL3NXTkp4V2wrNkxkbVNsK1hsR05sMVlqM1d1c0JtL1p4MTVYbGZi?=
 =?utf-8?B?MWsvdUUvam5DY1VCUVdnRndNaGMwNnlHdDZINCtQOE1Ca2ZmaCtUQ0hjb0Uy?=
 =?utf-8?B?VTFseFNTd0RTNzY0c0hsMUhvOUJLdWJOMXoxZmtXQmdMakxDMFpHOUN4aUw4?=
 =?utf-8?B?ekVWT1JYRncxNWdVVks2V21NZkhmSmt1MHZUVy9idjVlUitQV3ppTGo4bXNx?=
 =?utf-8?B?QXNtUDVlR3ZTd1dDVGh1VjJSbDVlWjVuZ1JDSHRjVE5IRDg4T2RjdTZFaGoz?=
 =?utf-8?B?NzFCUnRzZVVDNXdoeDNuSFQxdjlGWjBVcGFHbHMzdzdDWHA5TXp1REtHZTF2?=
 =?utf-8?B?bVB5SUltNk03YVQ4S1YvTWNRZXJxUEVGRUJaeGd6Sm1PQUtFMXUxVThQQjFK?=
 =?utf-8?B?RXh1TGtpa05uVEsvNGMxS3cyTjU3ZnlGRXZMY2NTTll1UHFqNmtrbm5Ic0hB?=
 =?utf-8?B?TUJoZVN5TjJwRFlqcmRYZm9qQ01WU290WTFQUGxReGVaWWtnb3VvbFp3T0hy?=
 =?utf-8?B?cmt6NHNiYks1VkovdVQ1MGIxWFA4ekhuNmxUamJhZkZySFZNcDQ0Q3Z0eFl3?=
 =?utf-8?B?K0R3VEZId3FPNjFUSW83S0pON3hqT0tOVi9RcXVXMVA5a2pwSWxFUE0rS3J4?=
 =?utf-8?B?V1paVEFsMW11Y0lFSTd3Y1RFWHlLVHovS2lHSTlIa2RjK2dEcVkvcWhWbXlD?=
 =?utf-8?B?dVFiVjVWZ3lZNWUxUWdPRnliRzdMUGoraTJ6WC9CTnMwWHpHS2tXU21BYnVM?=
 =?utf-8?B?RkVEdjVEbkpZMGhNcXFTdGpWd0hKMmx5WEk1cXBrSkhwMEJiNjR1bXYzREdi?=
 =?utf-8?B?NXZlV3Z5dWNlRzZBWmpOaTU3YTZhQngralJNRGI3MG52dTRmVDZENmFJY2dj?=
 =?utf-8?B?RkFhYTRCaUU5MW1MQUpYYjV0WmtuandjcXdsSm41VHdPMmxid2c4aUxuV3VC?=
 =?utf-8?B?UDZJcVNUbUJYUVQ5SkFtSmMza0UwM2NZU1hwNnV4NER3QjFmc1RRQ25rUHBB?=
 =?utf-8?B?VGRRWld5NEtjOWtBaXNjOWl3d3lVNUt3SzVDTDVoTFlyWjNHUTJzYVdyaWo5?=
 =?utf-8?B?RGFJZ0VweUNHVkpXZGNFZElXY2pQMVAvZVpPWUFRY3pvNXAyN1U0MHhuUWRk?=
 =?utf-8?B?cWtKd2R3RHZPd0NMQU01TG9QQlMrTkN4dEhhMGJja3poVHJOa0pFSlZhVFVu?=
 =?utf-8?B?c3BJNnpRb2N4WFJQQmRvVmIvQ3JwNU9MVUd4aGFJZ2x0cUx3RXlLOGFtVzg2?=
 =?utf-8?B?RDZHVy9kT3FUbWlVci95VmNmakVJaTU0ZUgwY2hKak9tbmFtTmwrM1U2TXJX?=
 =?utf-8?B?UFBubngyTk8wTkhNd1ViZ2pHZXA4K3FjSCtsK2R2MkFhVFJMVjRzTmJ2eHBr?=
 =?utf-8?B?OVpPVDlDckpvdzdjQWpVTUdmaFBvb0RrVERXZmdYN2M4SVpUaDNXSGt3ZlhR?=
 =?utf-8?B?QURUY0FZcTVURzJQa3FNOW5OMnhlNnFlWGNJNi9wOTR6dm93WnQ5UXROK0xZ?=
 =?utf-8?B?Z1lNeEdvWVQxVUFXQzdWQVA1VlFlU1VPYmt3L2dQN21GTUpsMzdRcFBYMGxL?=
 =?utf-8?B?NFNTSEVna1FDd2N3QmtqWXc4b3J2WFVSSWpDWlJLS1hLait6dEdtVUVvU21w?=
 =?utf-8?B?cURHRWRPWnVlWjUxYTBkZDBMVitIM2pNVGVVUGFNNWJTTm5xOUp5d3JwNDRw?=
 =?utf-8?B?SkRqTXl0aElwK256SVdGSUlnMU4ycTZXa1l4QVg0OFhFcUc4dytUUXN3VGlF?=
 =?utf-8?B?YnhWY08vQVUwb0VKcWViRlVoRmlSdDd2ZEIwNlltaW5iZGZlZlJET0hLMHpK?=
 =?utf-8?B?MFhKcTFaTzEyU3FNNi91QWVzZ2tJSXJTN0kwcFg2M29wM3c2b3FDcVZYWThD?=
 =?utf-8?Q?jNz4BmtfdFIHtqkI=3D?=
X-Exchange-RoutingPolicyChecked: T0OhKUaalr3dSNvtJVNpks8cabGENJyAZ3NzMgfBCM7mhe+QGrovkE3zBrpeeg/WrSRDgv9gLBpZkcc2wq0DCZTLoU5mGWhtc5ZgCLhSxqPQC5lcncp2jv+AnciBsTVcq3HR9lZ16ZINpgffd7PeUFTDOFd0q5z8VWsuekrFnxLjc/iBWW4ZB4V3l/MWwpZy/NsVSLELeR725qQDzCLYXmqxDn58Hl6ZbjEnvQsGfcfa4Dy8Punf1hgIjkWzRGKrLWF3hK0elNQj+i+oL4lOgI2hghu31OCZEz9H1eymQePCtAj7u5RcBmF4L2xGQRY8LL7ejTDgKUiZfjHStsQ9NA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 434bbff8-eec6-4737-7064-08df14d19fd5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 15:37:47.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADLnF5ki2JC4EpCdR+3gPZC8Pg04nBXYWfRrXqePVAH1+yQ1zUjmhfPSBUpmms7q9CEY88LNsZYEW1OqF6P7j1FMVouTt/lvttutgK1ax6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7502
X-OriginatorOrg: intel.com

Hi Drew,

On 9/1/26 3:31 PM, Drew Fustini wrote:
> resctrl exposes a single cap set per rid, so when more than one capacity
> controller backs a cache level they must agree on those caps. A level
> whose controllers disagree is left unexposed. Other levels are
> unaffected.
If I understand correctly, while attempting to translate to resctrl terms,
this means that a cache resource with several domains may support different
capacity masks in the domains?

I believe the "single cap set per rid" you refer to is
/sys/fs/resctrl/info/L3/cbm_mask and /sys/fs/resctrl/info/L2/cbm_mask that
exposes a single capacity bitmask representing the maximum allocation.

As you know, resctrl is in the process of changing the way in which schema
formats are described. The most recent PoC [1] added new bitmap description
files but it kept a single value "max" file to describe the highest allocation
possible for a bitmap schema.

To support asymmetrical cache instances it looks like changing the interface
to describe the maximum per domain (instead of one global value) could address
the gap?

For example, if there is a hypothetical system with two L2 cache instances, one
with a 0xFF max CBM and the other with a 0XF max CBM then resctrl could expose it
as:

	# cat /sys/fs/resctrl/info/L2/schemata/L2/max
	0=ff;1=f

The schemata file currently and will continue to display the allocations per domain.

resctrl will need more changes to support different CBM per domain internally and
until then all these CBMs will be the same, but adding this change to user interface now
may set resctrl up to support these systems in the future?

Reinette

[1] https://lore.kernel.org/lkml/d258a32f-12d5-464d-abe9-4720fb3e44b3@intel.com/
