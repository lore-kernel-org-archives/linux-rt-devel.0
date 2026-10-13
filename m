Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB52EB0F
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Oct 2026 00:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791850079; cv=fail; b=Xm3vLL1YB4jK6mNX/Ubg3+wEe0SFHS1BtsASyS2i6BvS08uiO805bejT7tjzAzvCNpxOn8jNgyzYxMsGy9+WwqfpTxQwx4lhTQa4Gyi30sYOTLB4mhEY4QQavcNoomKOekkn1/veFur3h3LZB87nrmK2Z1MjlTxITSogjfIHUG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791850079; c=relaxed/simple;
	bh=UdockhbMlGNWeL5bYALFbxeBgG/uid9c6UxBI890meg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c4C35Knj2G/b9K7Zq9MdfbywOe/hZZZ9NLOnHqcHIGuySgE7VXsyuvNgDTngX17TmTjl85/Foy+FHjo0uwFhMUyVch2AjdpVQNx/NdqRMJ5YrE1d3177T2s0RTXGDGEMXzKRCn1H7dvoBGMcTTYvVUQL1tMVXkDHn/o7WS0pUvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYCe20s7; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYCe20s7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791850078; x=1823386078;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UdockhbMlGNWeL5bYALFbxeBgG/uid9c6UxBI890meg=;
  b=fYCe20s7m6hZD0gsqBF7HvAhbGcmQ1WL/yfL0JyyZ42yN30kA6rIubv6
   HpiGn/9WcALJ2r1iHo4ugIrn8Ldhur68tsMNP0t+38jlz83QFH8aDXN0h
   1cUdIPNJEzhl0VM+xR4A2CchEYZ1AaJw/KmcvCgBIIY5JVCWa2TxIN0lV
   kwU0C3928TCFHy8kERjEgC5PClq+JkAAA/W/92+rVS0DtJYJv9hACM1lY
   gZlKJ/uAT7s/hJjU+mojlDLpQWXp2LXY7Mf8VqwPX8AF2dGqE9t0FEFQk
   1DBNMF5VmTYDkUh2Ax4pYHFV1gBUvUZ8XwWzE/yetcPQd09/5udcFhjoH
   w==;
X-CSE-ConnectionGUID: P+GGvzaQR/Wbs+S411fSCQ==
X-CSE-MsgGUID: /xTOSxmvTC2nL5boZqWFwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="576805"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="576805"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 17:07:57 -0700
X-CSE-ConnectionGUID: G113pLdDTZKf0hAsEpyVJg==
X-CSE-MsgGUID: JnTufjM9RoKbJc9VUD11sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1392979"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 17:07:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 17:07:55 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 17:07:55 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 17:07:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gr9AaN5tBWsmKGwZot+KBwhSBto4hzlAic+dplWjmlutLVVa1e2kSfzfMmZGCTTyE91kmbuJNC/7M97dbQIdW6DwnWJ0k7eLHFspl54b3fWJ9avcql89iqjLBMKJUodbr2S7c8wgIFTiX1O7Ndj9YkV8G/514am5eOV5OaX5J1NHwB24+tRhIspK+ogXa9VXN3vUjTuDi078Z1dopTdMPcAU0CvsuPJ+cbPx+8gIJ4CDQyXJ48GF0t9anudE6ESB1m45hzR0O8zuB29nKJtBwuAUoml7kG5Fqrp37vbYSS72Q3MMTu9AAW9P7D8KNtbVNEQf2V59JQNYHqMMUTo81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONsr4wXkPIv2r/MI+XFXiXlS20B0Bn7QHbbzwYIaDPw=;
 b=FmyOPplZS0ZJyJ9SBeqxHrgEZNI0kYr9hpv6I7pn7fUzWirbl0+ArK9VoZTjIIVkzZ5OcqjxXEtzPUBS9wMyadWSgYCIX+pUpTjftk70doJsuzzMQ81a/xbSBU3cHJTs/mgogpSp/6o1fLMQDyODqYC5lxbx7TFvUJabJbm5LxMx0IWMvUaYe5X5kQgpE/jKaNx519LiDBf9psp3kZJDO6Z/Mw6q4s4+BST4IXsOlQTxLfFqDsCPvHcV2XWxszKJmWqmfJ98sW1RUTy1qG5frZDym6hkyp6mlPKlDcrDc3DLdp4tfew1SWY8ILWAxyXcTmu6ObJtrt6Ln7/ys4e1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by SAWPR11MB9711.namprd11.prod.outlook.com (2603:10b6:806:4cb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Tue, 13 Oct
 2026 00:07:41 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.018; Tue, 13 Oct 2026
 00:07:41 +0000
Message-ID: <eaeb4259-46d6-4656-8354-669ad32654b5@intel.com>
Date: Mon, 12 Oct 2026 17:07:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
To: "Luck, Tony" <tony.luck@intel.com>
CC: Drew Fustini <fustini@kernel.org>, Adrien Ricciardi
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
 Andrzej Siewior" <bigeasy@linutronix.de>, Vasudevan Srinivasan
	<vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li
	<liwei1518@gmail.com>, yunhui cui <cuiyunhui@bytedance.com>, Zhanpeng Zhang
	<zhangzhanpeng.jasper@bytedance.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <x86@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
	<linux-doc@vger.kernel.org>
References: <20260901-dfustini-atl-sc-cbqri-dt-v7-0-ca2935d85622@kernel.org>
 <20260901-dfustini-atl-sc-cbqri-dt-v7-2-ca2935d85622@kernel.org>
 <8230dae2-2cb0-4b46-8cec-dc4e281d4e4a@intel.com>
 <aqwN1szItGPg4Qjh@agluck-desk3> <as0Zeoyjiy5CW1DT@agluck-desk3>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <as0Zeoyjiy5CW1DT@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:303:8d::7) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|SAWPR11MB9711:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd8c6f3-53d2-4622-7e48-08df28bdffd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|6133799003|3023799007|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: isgdq8Gg0gk8dxwa5SrJ2wYjMwtZ+Gu88Eamjnxqa1W+s2txijMiotZ5POnZIRM1VQvP1FuF4BdTn77QXuAtl20qMCaJn6GFdCQa+BRisnF90US8n2dJCiMa6YtLD3sgHVwfuQz/ZvVx+/aTEtKeEP4L+Lwu31W48KbUMKmWxWnxB+D++xP/O6T46AdwmMl8bArVKiDcJL+vIPx6Qu0Ynl+7FYZxtPoxis6mdRQeavqiW9STwJdtzY5YKplNHuwRcwSDsFmNqxMSIW7ACqYsQWsreZjswnfu55CfGN4ED/5g1HFnqdX8/u9Ni3c+/mfaLJLfH8pevdpXzEJf0I8WmMJXz0gcYStHZUtbrkCDIJIHtjPVGHvJ/zHg404jns0gE9SATs6dhXZL/Ql0njO+FgC+Qw5luisZMaxZgPCYIhHuvY+ypUiSR2d4rq37POlDEsXfIMkCi4RVydVvrbYD2MO/osweigAS5HsN+xZnxKuWmWoZ2awl6RikuvWkzg2/Bqxd92TMimWLJDKnUl0FQHHj28l9URC2WXXhhlNppXAuWzaTemZrOFheR6INoErPLCoMXQkDMu7gnAILxWX6uzwwDo4OubKt+36mBD5sdblfzIvMfDcnytNk3+Em7kxA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(3023799007)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXF5V2RLL2hVMDVNdDJnWUQraitMaTlXdmlsL3Vvdms5T2FVQXRMcExEUkI1?=
 =?utf-8?B?dmEzdTV1SHcrSnVZTUMxdDRiamFmK3pFaE50WlI5SUFMRmVTb3VtT1p3MkxE?=
 =?utf-8?B?RDJZNzZsMmp6dWpwYVZORUErNGRxdUI5b2ZaNnJDdlNHdTRKMXM3RURXSWFz?=
 =?utf-8?B?ck45NjBqUWlnRU1BNDc1S1VsbU1zTU5TS3VnNXhka0JBdzFHRi8yNFJCR0xZ?=
 =?utf-8?B?YnMwODR6b2ZrQ25zZ2FZM3hUc0ZxVVJGZGhtTjJjNUlwUGRiT0VFRGF6WXFv?=
 =?utf-8?B?ZWRkL3NZTmRSZExLcmp3MitlaDg5N1lHdXI2c0YzeWg3bWUreXBwVzVCUjZC?=
 =?utf-8?B?ZlJPbnpHMFFTZ3JiSWlHLy9rajVvR2Y1RjJMRlhOWSsxeXRPMXZTd0pvZ04x?=
 =?utf-8?B?QTB5djY3K0d2RHdCSi9Jb2EwOWozM2ZKV2VMc3BVVFE4b1dMQUFPNEEwMnVv?=
 =?utf-8?B?V0dUWHExaXk4eHBOdGtXTVJyMldsMitjYkFlOU9KR1BlWGhYVTlKdVlOR00y?=
 =?utf-8?B?VURjOWVJclpidmlCNFpvK1FpLzM5QXREbk5tMllRMkRLb2U3SWpaR0lUL3ZU?=
 =?utf-8?B?ckVFU0sycFM1N1oyckgxTUVoUXVSYUxCdUpmSGJEcEkybnJJUzIzSE1kcHc1?=
 =?utf-8?B?enlINVY2SURwcUM3NTNSRS9LdXpZL25HZHlVSzZETFBkVllDL0ttTlNaMHlW?=
 =?utf-8?B?bkc5R2FBMmpmOVhJUENJMmpvU3o1NUNHMHZySExEVHlNckJaOEJOYnBWdFVw?=
 =?utf-8?B?Q3NaV2QzYkpYR251aDNSVU4vRUFwUFBBRkhLT3VWSUFGdkhoQWZ6ZTYzYTNE?=
 =?utf-8?B?b3VUUC96SVAza1l5cVY1eU1Za3Q1UkZwd1pxOFVhUFE0OTR2MVY1Y1FobGdW?=
 =?utf-8?B?N0F0WkwxYk1Ba1hZTFQ3b0xuTHlteERKbHQzSk5wY2xoUzZwbHo3aTZveEpN?=
 =?utf-8?B?MG5MK2RFZGMvbGdXNXF4OGIwcVYvUjAvekZzUkx2ckRYSHJQMVozVWhrVHVa?=
 =?utf-8?B?MTM5L2VqT3RBbGVjdmxMMGZMY0J0U3dWTUhEdmQvSGphVklSMXhaZFNCMCsx?=
 =?utf-8?B?MnZQR2NZckJTK004akc1MTFWSDZzcGFHbnltTHY5SHdmQmF4V3hXOVhlZHpC?=
 =?utf-8?B?Y3ZDUldlVWgrbDI0NlVFTzdaa0kvelkvdGpJaDlGeHNkaVB2Vnh2MW9RdFB3?=
 =?utf-8?B?K2tTVWlqVTZkOWhvUTdzbXlxZWhJVnhhdjgrVWI5dnlINzkxTEJKZzJQR0E0?=
 =?utf-8?B?cmQvYjYzTks4b1JLdEE4RjhGaEFjYVAxbmRBMTM4TWpSaGFPbGhCd294VWJm?=
 =?utf-8?B?cHBnamNLMnpqWkNkV2ZDeHcxRnZvVWErc2ZobkgyWUJ6L3ozbWs5bGY4L2dC?=
 =?utf-8?B?eFhEcmlTYm9TemlYN25tN0VaR1N4cGRKNUVkMnlXSDE2Ti9NRFJ0a1pXVFlU?=
 =?utf-8?B?ajRIbmZ3REppdnNRdllIWGNsT0s5WGNLY0RHYnBwNVdHVWNLcEU4bE5oU0di?=
 =?utf-8?B?Nk9MLytkNk4zZkVOQnNGTEFSU1p2SGdSRC9sZURUNGY4SlpFalpsb2JRT0pk?=
 =?utf-8?B?VWhqdlpBWW8wZmZ3a2w0d2x2aGtieWtPTEFqa0Z6SEVXYTl5dk50UEVCbUlk?=
 =?utf-8?B?cjRoSkFoR1NFZHJVa1RHSkFFeVcyVlV0VmZjU1ZlWUs1cDNnN28xWlBHMG9N?=
 =?utf-8?B?aitnVmVwWEdGUnlDUzFFei8zd2dCeThYcHZ3TzE2YWFFMW5rVlE5ZXBSSmd1?=
 =?utf-8?B?YVhxMG15aWZHa0ovdkdFMU1OU00rUE1vYXZJN0krVlFZYXhPekRLaEU3eWZs?=
 =?utf-8?B?eDAwRE8rU3FnYm9BdjN3Z0Q5eDdLVEU3QWhuQWpEdk9aSW16MjNNbWNFdVIx?=
 =?utf-8?B?aHBxRnUzamlueEQ0K1NtUXphbDNadXR2eEs5dndzNzVuMVZXQkZjaVFtZkpR?=
 =?utf-8?B?NUNWWUY4eHdLTkpPU0VMTEZSSE1ObEFxU3Z3UXlkNzZ5cE9GOUE2M1IrK3Fv?=
 =?utf-8?B?VlEzSis3V1JIQzBHVXhFNjJESUl0UVZ5OEJvaUlGK1kvbUdiZU9MdWEzUW8z?=
 =?utf-8?B?dEVnd2RvTjc1QVN3U2wycmtPUmI0Q1FiaVU3VUd2VzdJb1lCdzNJWmlPSisv?=
 =?utf-8?B?NTMrVkp1SnZTY0l4Z1ZFb2dIL0JjUVcvTHh0QzdPRmRXQzVPUXhwakowWW9a?=
 =?utf-8?B?VXBjTXJQaGV3NWZjL2Y1VVZpYmVveVNEMFJYbEU5dWVXc04rc2RCaVFtQXYx?=
 =?utf-8?B?Yk91WmJ1NWRzTDU3TEpqL3FPckI1TTZUZjRWcVBtWHlZZTZxak1iY2JxS1Z0?=
 =?utf-8?B?SDFacHJvNVNadkZ6M2hONHpRRzVwRDFCM0p4aU85d2ZaMnE4NUJFVEFSNFdy?=
 =?utf-8?Q?LEyCXhIdDvMcK130=3D?=
X-Exchange-RoutingPolicyChecked: yrr6a+WfsYTPy89FNnQYcsM8ksK6DpFkLQmx55hrRoROY7M5EG36OZsA6OJLH8FuPWjVxNqvctE1Z/Plep0X8YKRFGTRV6Xr/9h7fZ+CKSidg4SSrCFnU/0DQ1mGUKnQzXBd02Q534YwkJSDAcAUOb1RFW/y7UUBOiSJkBrnmnsTIreFuEKF2lC5/BSdlnx1qyYPMZHdCe9Rj948a+QVaOIqecdtOVRsa6L6n/MXAwmrJ8zkIOaMKiWpg0uBI/qQYH6hvbS6Z4DhgeZH7aQPeqxxjJdYzAPbg1f0vukSQNdKQYCvMg1mDm9/1BtK+XkVC9/T6QJhhJfO51wzq8VviA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd8c6f3-53d2-4622-7e48-08df28bdffd4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 00:07:41.7411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r75Zn7wPoQmFUrW88l0zKM4ymXFjfUdR8eCDoTNW8vTfQ0S/bkn0148cNH6CHyDQhPahouZBAh9udgdaYD02PZ4VBLSyD49riwHvplZlQIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9711
X-OriginatorOrg: intel.com

Hi Tony,

On 10/12/26 10:31 AM, Luck, Tony wrote:
> On Thu, Sep 17, 2026 at 08:57:10AM -0700, Luck, Tony wrote:
>> On Thu, Sep 17, 2026 at 08:37:43AM -0700, Reinette Chatre wrote:
>>> On 9/1/26 3:31 PM, Drew Fustini wrote:
>>>> resctrl exposes a single cap set per rid, so when more than one capacity
>>>> controller backs a cache level they must agree on those caps. A level
>>>> whose controllers disagree is left unexposed. Other levels are
>>>> unaffected.
>>> If I understand correctly, while attempting to translate to resctrl terms,
>>> this means that a cache resource with several domains may support different
>>> capacity masks in the domains?
>>>
>>> I believe the "single cap set per rid" you refer to is
>>> /sys/fs/resctrl/info/L3/cbm_mask and /sys/fs/resctrl/info/L2/cbm_mask that
>>> exposes a single capacity bitmask representing the maximum allocation.
>>>
>>> As you know, resctrl is in the process of changing the way in which schema
>>> formats are described. The most recent PoC [1] added new bitmap description
>>> files but it kept a single value "max" file to describe the highest allocation
>>> possible for a bitmap schema.
>>>
>>> To support asymmetrical cache instances it looks like changing the interface
>>> to describe the maximum per domain (instead of one global value) could address
>>> the gap?
>>>
>>> For example, if there is a hypothetical system with two L2 cache instances, one
>>> with a 0xFF max CBM and the other with a 0XF max CBM then resctrl could expose it
>>> as:
>>
>> That sounds like the not-at-all-hypothetical Intel hybrid client parts
>> where P-core and E-core have different L2 masks.
>>
>>>
>>> 	# cat /sys/fs/resctrl/info/L2/schemata/L2/max
>>> 	0=ff;1=f
>>>
>>> The schemata file currently and will continue to display the allocations per domain.
>>>
>>> resctrl will need more changes to support different CBM per domain internally and
>>> until then all these CBMs will be the same, but adding this change to user interface now
>>> may set resctrl up to support these systems in the future?
>>
>> I think Fenghua once worked on patches to support this. But I don't
>> think they were every posted to LKML. One of the open issues at the time
>> was how to handle the info/L2/cbm_mask file.
> 
> I took git://git.kernel.org/pub/scm/linux/kernel/git/reinette/linux.git
> branch resctrl/controls_rfc_v2.4 and added some patches to support L2
> per-domain cache allocation bitmasks. Seems to be working OK. I can
> share the patches if anyone is interested, but they aren't even up to
> RFC quality yet.
> 
> I do have some questions:
> 
> 1) The repeated "L2" in the path seems awkward. The first is the
> resource name, the second the control name. Makes sense for MBA where
> there may be multiple control names. But for cache ... is there a better
> name for the control than repeating the resource name?

If we are using the same definitions of what a control and resource represents: no.

A control is represented by an entry in the schemata file and is what the
user interacts with to configure resource allocation. Today there is a 1:1
relationship between a resource and its only control and today this control
has the same name as the resource. This is not something we can change at
this point for a legacy resource like "L2" since it is already represented
in the schemata file by a control named "L2".

Multiple controls is not just for MBA. There will also be multiple cache controls.
For reference:
https://lore.kernel.org/lkml/20260921135702.2874931-1-ben.horgan@arm.com/

All "legacy" resource have a control with the same name as the resource. At this
point this is not required for new resources with first resource like this planned
to be MB_NODE.
> 2) Should the format of /sys/fs/resctrl/info/L2/schemata/L2/max depend
> on whether the platform is asymmetric? Or just enumerate the per-domain
> values even on symmetric systems? Likely easier for users to list all
> domains.

If it depends on the platform then resctrl would need to separately let user
space know whether the platform is asymmetric or not. This additional information
seems unnecessary if the only motivation is to let user know if the max values
are per-domain or not. Always listing all domains seems to be the simplest and
straightforward option.
> 3) What should happen to the legacy /sys/fs/resctrl/info/L2/cbm_mask?
> Just hide it? I also considered renaming the resource to "L2A" to
> avoid surprising legacy code.
The current direction is to have these top level files continue to return
the properties of the default/legacy control while in "legacy" control mode.
When user space switches the control mode then these files return empty. 

This is what is implemented in RFC v2 so you should be able to see it in action.

It was noted as one of RFC v2's opens:
	- When switching control mode to native the top level control info files
	  stop returning information. This could be considered "work as intended"?

An example of this behavior in action as applied to "min_bandwidth" can be seen 
on slide 4 of
https://lpc.events/event/20/contributions/2368/attachments/2066/4625/resctrl_2026_combined.pdf

Hiding the files could also be an option. I have not heard strong opinions on how this
should be handled after the above mentions of current direction.

Reinette
