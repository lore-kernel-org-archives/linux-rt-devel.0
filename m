Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205D552932
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Oct 2026 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791926994; cv=fail; b=TwVMbrpM8r94DxYKgNFbxEFINTVo4gHXH1wREnWF3qJXEAqIpWLFT2PGG6Ee2mei30ZKqKLPNXKBPbYWhMe/NpZPO0YosWZRqHHXab+KETaysK94yrkT9xJhXy+5hnYubOW97HiKy8H0/RoqzwdLscBjniFdXbeYEoBjdlnM+r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791926994; c=relaxed/simple;
	bh=91UtN3mmfUf1Z+cDWFMSX7fNvPP8qSebrG5ycJn0gfE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kJdL1hr/P4hqxpIPFgG4bv1GQo9j4gVGZBYbNOfoZgTYNzCozXpAb+zKlBWnwHhThKRzHzIKhQaQQW9chAiHoX8V2dMR/tfx3IMHvoaH6EsPkyp0VsrYHOGaf6hGeKvlgOXt0lpRgJwKgXfh/YqrtOA85ss1TehkF3TEgdbIk4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNVVFB/R; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNVVFB/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791926992; x=1823462992;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=91UtN3mmfUf1Z+cDWFMSX7fNvPP8qSebrG5ycJn0gfE=;
  b=kNVVFB/RrXoPIdqyEKvYMIR0YlTVDRTJobkhe4HoBvrGrV9KNsx4Lkbm
   cdAZNyVVfBeW8qxVRrZzeSXMIwmTqd/D6tfv+mt0kaFua4UAeB9NpbWr7
   MTlM+JxLWmWj00sDhgqEmA0xdqVi91ozSaKlARuIU8DjMTHMPQkLVExkD
   f+WU5EqeOcLZAeRuR4RhaW9ixLlfT0kX9mjqqUAkPrwTDrw/CMPlehaN2
   RQrfx8D5q80hPUC9UNAlvaDcCfQXOnxZ4EMFqArQtbQ9hWupl/V6jQ1CR
   H91p3GJOU19+3VHU7xhm7RsWvwzHfupJurcZoC3Dya/U3/Dy2TwwaC8hE
   Q==;
X-CSE-ConnectionGUID: 0aOmeV6aSB2o3Dvt4WA5IQ==
X-CSE-MsgGUID: D8MjZBgXR5+2W8xypGjkRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="659266"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="659266"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 14:29:50 -0700
X-CSE-ConnectionGUID: 64WupohkQcW4aiV9TFHD6Q==
X-CSE-MsgGUID: k35L152fQhm6i7hbv7F9HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1290075"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 14:29:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 14:29:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 14:29:48 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 14:29:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpSuclO7Ql5Uly9V1VtRTdwUuVfjub0S9GfmtLNHUHPy/0FnVuiyOd9Hm6jm0PG58JQ/fJ351kpjz5ft371SRyFkfQDPEE07EWitN7vnId+nRGWoevfOM6OT/PcOBip2mOn1pExip0lYWm2Os+T9wzKe35pHTS+9Eqx3ZGhZbZyAnn9JlpFE8jJdZDdHgTCO/ESI/TjyCJXsplvTFavnUuKnjfSB4JZRgfJZKifu/sDsIxVpXzUMKabmpUN+i7ZJdVrds6XhipZpcGbDOyZsRIc0M+KeUxHlv33fPsHxH2J2SiQY/NMxc8ukUvjSrCaYM++d9MSHu+O0u/IYv0YmIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yr+TjrJGPoPGOobPJx89jpmVpGsbzHRsfnQLqtiCuTU=;
 b=wbOlae561dQsLHwp4YaxgorPf3mwV3+7cJFIT/yZS43AxAK+NPuR0/Alep7znSRnwYCKZDUcB2AkwWOw2wxRMot/uc0TTk3GVAReDFgkQ4UcL0IaEsFHExEuM+zJvx+mg1TBijBDp2cFXsLXPU5i8tpNTdGjqY4DxWfvKMemtXy6DKn/RMI5d4W1xkWvSHD3bi0izYEUIhtqkGwM/srcoNslQmmxOnt4OmHjPtBc+OBVCt+RW0A7zDm56Pyde3OUFNcGbM7RGpDVKo8tVWHNlPWxI/lttpvXGCv2Z6j0o2BczU5/TBeXj7ioKuhQSYqT3iURjGhkDcbu8mcjS9gE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com (2603:10b6:a03:540::20)
 by PH7PR11MB6353.namprd11.prod.outlook.com (2603:10b6:510:1ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 21:29:45 +0000
Received: from SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc]) by SJ2PR11MB8370.namprd11.prod.outlook.com
 ([fe80::b6cf:ce77:3cdf:7cc%6]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 21:29:45 +0000
Message-ID: <22ecec13-a703-414e-9f5e-75c89173e845@intel.com>
Date: Tue, 13 Oct 2026 14:29:41 -0700
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
	<gsh517@gmail.com>, "guo.wenjia23@zte.com.cn" <guo.wenjia23@zte.com.cn>,
	James Morse <james.morse@arm.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?=
	<mindal@semihalf.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"liu.qingtao2@zte.com.cn" <liu.qingtao2@zte.com.cn>, Liu Zhiwei
	<zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>, "Paul
 Walmsley" <pjw@kernel.org>, Peter Newman <peternewman@google.com>,
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, Rob Herring
	<robh@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Vasudevan Srinivasan
	<vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li
	<liwei1518@gmail.com>, yunhui cui <cuiyunhui@bytedance.com>, Zhanpeng Zhang
	<zhangzhanpeng.jasper@bytedance.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20260901-dfustini-atl-sc-cbqri-dt-v7-0-ca2935d85622@kernel.org>
 <20260901-dfustini-atl-sc-cbqri-dt-v7-2-ca2935d85622@kernel.org>
 <8230dae2-2cb0-4b46-8cec-dc4e281d4e4a@intel.com>
 <aqwN1szItGPg4Qjh@agluck-desk3> <as0Zeoyjiy5CW1DT@agluck-desk3>
 <eaeb4259-46d6-4656-8354-669ad32654b5@intel.com>
 <SJ1PR11MB6083F4281EDD036A4E73A532FC9E2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <a85a5aef-5468-47ba-afba-8bdd666dadd4@intel.com>
 <as6Y72SbiXcJh6Ei@agluck-desk3>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <as6Y72SbiXcJh6Ei@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0269.namprd04.prod.outlook.com
 (2603:10b6:303:88::34) To SJ2PR11MB8370.namprd11.prod.outlook.com
 (2603:10b6:a03:540::20)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8370:EE_|PH7PR11MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: fb2b3b1f-877e-4af2-e18c-08df29711a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|18002099003|22082099003|10067099003|3023799007|5023799004|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 5LCxcmKbLQxEXZkH8HVpJ9n6++zEt4eJmSEXpsljqyIZNGacwt2R3tN8I4mYgzcD4QGh7VjV485tsnd8AsatE6VWTJXhRT1ACLR92cvhbtKSnxGSksj5mtkmAR05XM4wPh/ZbaATLfO4nQh8KMKJv5LF0Bljfe4cS2Q8qMJCCoTUu9DPclH/StLpV7UaIZAYGu6ADUhtMyTaPH/RVb8OQ9ZzutznFK2Uhk/An1BsCKOJ3lUTAVb9umFeoZ5/vVlaLSnccXuTtY8KrLfjQHJ64ylRRMcUYAFF/qZxa+cVV8WP730Vb49CBYe/UwuL+BUZ3WNyNFI+pdaAKKKnsTjuE9FvHO2QzesT+GO8pWlJxzSynRgafHO4Zw5/kdC93KhkrtkbqQ4JDajTbnfntF1J10vofHNdtikpI4DmKk6pO+mTBEEoKOIMhmtltRpFJE0hzN4BKam3IF1TtbnPl4IBbEpkhin8StJnW4sKkkEBLsiV2limNM0Ofmt/0OucF7RGcOuhFExGGjI6sh29H5nq33+gGEY+Kbu5QXX+lBpElJ066hLnr4GBsqj2HS/3TVqyj/q4fTfXNjzoELZ/w05LT2c9/O/e3rozpr+qobnigr/YU5Ay6nY9hymsmpMpYr0P8pe4lYIE7CXXrzssX1oqYrLkJMSC0t4c/Cuf9BtTeOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(5023799004)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1ZpbVpQSy9yQitwUUViUXU1SG5scnprSTZnYUVJSUpzKzdNMndvRDdDM1pS?=
 =?utf-8?B?d0NEaUxkYXRCVjZQMnVNTFovSVhheGdPYW5wbEdUNGtzUVR2N0x0UXpYSVE5?=
 =?utf-8?B?bDlBVytmNVhXaGsvTlV0SnowL2FkUm5NL3BlNmg2N2hmNjBxU1FZQ0Y0WmJs?=
 =?utf-8?B?WVhobG9UWXVWbXU5S3p0UFo4dWtocXVQMmNoNlRPZ3dVSFdHVjFMR2Z0a0ky?=
 =?utf-8?B?VVJmeGg1YmMwQ0NlUUVRQVV4Ty9DZithRkkvOHhvcHR6Mld2bjRKaHVkTm1k?=
 =?utf-8?B?d0pBSDY3R1BtQnZnZnVCcGIyektQeWZJWHBGQ3dWSjg4SnUzYVJJZTlZQWFK?=
 =?utf-8?B?VE5ZTVdwMm1aWWNZaGJuSVU4cXRNb2p1bnI1V3VTbGpxZ1hYSDZUT3dFZ3Nm?=
 =?utf-8?B?RmdIZTVZMVVCNDFJeXFLWUtOaE1XR0FOT2Ivc3ZYMFVwVlUxa0tjUzNEZUh0?=
 =?utf-8?B?bmVyNkpMMW8ybE5qVCtrR3d6TkM5c1pSdEpiWFYzNG1ETzhPWDNZR25keDh3?=
 =?utf-8?B?RjVDNWpzZ3c0RWlRREhGMEVaazJKUkZlSW5UdnFWNnVFMllFNzd4VXBvSHIw?=
 =?utf-8?B?K1RxaGI1U1hHTEFIaEhkU3dWV3VxMTVYeDdBZ3dZdUduZHNRY0Z1RkV5dmJS?=
 =?utf-8?B?c2piZnViNWhieTQySGo0NllFZGJuN2J5dnliOVo0dkZvWWtYVmVGOExzUFMw?=
 =?utf-8?B?Rkt3cnVMYkJ0TUxUS3J1KzYybkZLdkt0Nm9sdlhXOEZDaWsxMmRjSXVTMVY5?=
 =?utf-8?B?Uk0rdzJ4djRzWnRRa1UyRU9yVVVQbFVTaHlkOWJpVFhmVlRtckNIYVd0eGcw?=
 =?utf-8?B?WGNJNlBkOHFmRC8xbitOclBMNFhubmU1TXFmT3RKOWtFQ3hsRUZLcmVUUDU4?=
 =?utf-8?B?dDdWNTl6bnF3S2V4cnNnMjBaQmRITW1RbU90YmdydFFqNUtjbncvSnNlQkR2?=
 =?utf-8?B?SjNCSzRyRi9sbXRleXJkS2dxbkk5U1FFdkFDK0lKRWtrMU94M3pGK29Rb3E1?=
 =?utf-8?B?ZUxNVkRVV2l6Y0thSGFhcEwweTFybzR1R0ZOQTEybU9ac2txNkhwb25LMTh4?=
 =?utf-8?B?TFd3Z3pzZnBWc05oYUxiZjRYZTlNYkxlM1pWMlZ2c05Cc0NSeVlIWkcyT0JZ?=
 =?utf-8?B?Q1F5bk5acFZEeERoM1B4SFcwK2oyeFdYTlFLaGFKV29aWlVrWER0c1JYamdm?=
 =?utf-8?B?REZjSit0MUdXd09LdzRsVXp5OEhtUkdOemFLR3RaQ1VaOXJva2xNSTdhMU5w?=
 =?utf-8?B?dHNkd1Q2M2c4L0NqTlNmWlA0ejArM0t4eHlBZ3VSN0g0NURxL1VyVWEydEJB?=
 =?utf-8?B?T3VUd1hyODVIbnFPMkFjMTZRZHQvMmJwOVYyaUxWWHFKeFJjU0s2c2czVm9u?=
 =?utf-8?B?UlozRkhKeFJZbUVySEloZ3phUVViV1VveG1mU2U1Y0lYR1FlcXdObis0WWpu?=
 =?utf-8?B?ZFh0bzhZVkhyNUExaW96M0VyZEdyWG4ra05IUDVtdk1PZTBPR09Gem50TkY0?=
 =?utf-8?B?U0gvb1dHNTFHWnRKT2VFTWp1bWE5b1VXRkY2L0t3eVlDK1lvamVYeUxTT3Bw?=
 =?utf-8?B?OVQraXBsVS9nUVYzNms1cDlRK2JlSTZiQlZoREl3a1Z5ZCtIWCtVa2NDZzdN?=
 =?utf-8?B?Y0w2ZlI1K2FJUzFKYk05S2M4Z1F4STZsRHpvK08zd1Nna0ZaVy8zTmcyUEEx?=
 =?utf-8?B?ME1DR0JaankycUZQcS9oekVIcmgwMU16dE1HTlNxZVY1NGVZMG1xdzRDS29O?=
 =?utf-8?B?MlU1N0IwV29yVHBPMnBMNU5HemZnQlZ1TFVJbTJ4Mi91TDVXN2lGT25PREY1?=
 =?utf-8?B?SVFsYlU0TUthZzRkNlVydWlHM1lCcThvRFJUVnZuaU5EU0RNRHpaS2dpUVp1?=
 =?utf-8?B?cjgvZ3VRcG1TZGk4eThXRmloNDY0M08wYjZZV0cvWE8zd1lVRkJrQk0zYnpG?=
 =?utf-8?B?Y3ZyS2wwbHVBVXpKUW0vaVBpT3FiMVFGWDBjd1NqVzZ4Qjg5YmNOWTRvV0Ex?=
 =?utf-8?B?NEJqOTJFVFRtQzhRT09qYWc2TlhQNEhJVDV3YkcvSkF6OWRISnVtYWpWUGxa?=
 =?utf-8?B?dTRrUUtDUk9iR1RiWlNacUJKeVpMSHhCczhleitqbVBZWHFRZzBzODJJVmk2?=
 =?utf-8?B?azVVVkNHdm5zelNYTXFmcGpmckY3ZmoyMjBjQitSdXBCcUExY1VzZ0E5YVAx?=
 =?utf-8?B?ZUt4akJ4TXpiRjV4Y2k2TmFHakNkeXJNbEdNWFVoaHpZS2lzK2NrV08vcUNH?=
 =?utf-8?B?SDFSOThhdWNQRDBSWFhqRXlFK3VMME5BenJ0MUZ1UEdHQ3ZuQnMzaUQ2QmNL?=
 =?utf-8?B?NWxPeGtxR3Q1MjFjTEU5SExwOEJRd0pHNWpaTXA5WmtjWkhLNE1xbTRBYWho?=
 =?utf-8?Q?dJ2BR6ZowkaYBS5E=3D?=
X-Exchange-RoutingPolicyChecked: UiztQpdRNQgNSWfPe5W/l2qz1tqHxg2E4VpCMH+HgTOV0xjeF6MKG8ywOBxmj3EPMvLp+5vC4dphKXTUgi6+FfJi+c573TLffiLbkp3MA9NGgInl6sfrmJZ6fi1ATq/Fp+8glvD7y9mQ5ncLb2eTG6cdSgKcaudCcUAfYjqZ22ynjz4XbeaXHno/Hy0uFmmpV0967Iud2s5XTFfyWAFKllngEOuNEj/3pMnrBQp+9Rt+txl9tWEA5i9KJCt4b54ZzJIE0nSukpz1+01cSCATW3wRUILXarSqmssdlczRyR/hWLXjFy+ojM1OZNRb+wy9YZIrnQNwfxqLokwOO/7y9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: fb2b3b1f-877e-4af2-e18c-08df29711a00
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 21:29:45.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeO0j0ZCH5otn3ubFlIMfwc3On88IHE61Jx6fhvqbqAF7BRiUZUNcmmvwjcgHcxE98g7sPY3lTZO+wS3CiUKhuHILH1DGL3aNKokzSRU5tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6353
X-OriginatorOrg: intel.com

Hi Tony,

On 10/13/26 1:47 PM, Luck, Tony wrote:
> Reinette,
> 
> The system I'm working on has L2 caches that appear like this:
> 
> 	    L2:0=fff;1=fff;2=fff;3=fff;4=ffff;5=ffff;8=ffff
> 
> The P-cores support 12 ways in their L2 caches, the E-cores support 16 ways
> in each of the per-module L2 caches.
> 
> A legacy implementation would have to present just 12 ways across all
> domains to the user. The implementation of that has a couple of choices:
> 
> 1) Ignore 25% of the caches on the E-cores.
> 	Unlikely to please anyone.

Just like the percentage based memory bandwidth control is not able to
please everybody but it is something that can be exposed to not break userspace
while it can be emulated with the underlying hardware controls. Users needing
finer grained capability will have the option to switch to the native
controls.

> 2) Silently allow access to the "f000" ways of the E-core caches.
> 	Doesn't waste the hardware, but if the user tries to divide
> 	available cache exclusively between groups, the "free" extra
> 	cache would result in surprise sharing.

(2) requires the system to support sparse bitmasks.

> 
> The drive for L2 controls on hybrid systems comes from embedded systems
> where expectations would be for the controls to operate precisely as
> written without any fuzziness.
> 
> I'm not seeing a market for the legacy behavior, so implementing it
> would just add complexity to resctrl without any benefit to users.
> 
> Perhaps keep the "L2" resource name. Use "L2" for a control name for
> symmetric systems. Use "L2A" as the control name for asymmetric systems.
> Legacy software won't be confused because there won't be an "L2:"
> line in the schemata file.

This cannot simultaneously be a market that does not require legacy behavior
and require legacy software to not be confused. Unfortunately I believe
legacy software (which is the latest software today) will get confused.

I understand that there are many different utilities used to interact with
resctrl so behavior can vary. Based on my understanding of the pqos/intel-cmt-cat
utility the system's capabilities are determined by parsing /sys/fs/resctrl/info.
Based on this parsing the utility expects particular entries to exist in
schemata file and interacts with schemata file with this expectation without
checking whether a matching entry is actually in schemata file or not.

The utility will thus inform user space that L2 CAT is fully available but
when user space attempts any read/write the behavior will be unexpected.

> 
> Don't bother with a control_mode to switch between legacy and native.
> Just auto-select the "L2A" control on asymmetric systems.
> 
> But since this thread started from a RISC-V thread, it would be good to
> hear what is needed for RISC-V.
ack.

Reinette

