Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021090.outbound.protection.outlook.com [52.101.62.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C63B52FD
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769036258; cv=fail; b=d17MjUUXIrQQhnZA1Htw7BAmXjQADL80YNTfpgFuPZvOTzO0b8edMrzXa450VBhTPqp8RgzNcgZn3kKHlwLc9wFpKegBF98SQlrbzqvTmnPr1l7DJteHVHbXFajf2agR9KFLMg36KVekDtp0V9s2vqsf1Bgv+2wN0DwdO5/LRtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769036258; c=relaxed/simple;
	bh=qEk8qfuBtSFErw9hu+eLwlm+JhGxNPuwHH8MV+6rYw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zspv5zNhOmxbLSKV3CtR/N1AL0bWBeFIx/3s2+E3XqAa+MmTY1l5gLx3Wvnb06LCH3NI9/A/qBQo47uUBBJzhxMAZBIkeW9E7l3fCs40G+8gYD5QtTGFq25LydF5m89WfSQf2sWOLBp66aWywyfDlrfnwZUom9vnt1c7KQT1mF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ThGDWFfR; arc=fail smtp.client-ip=52.101.62.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ThGDWFfR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+VcTFy0VYva5dyWGTUB/dAm4bigkhpIGlz0Z57dJZM84JDeipAEg+ZX5EhgsysiWRlOYUysF/MoPAd1Brrd08qIzEb8k9FkGpAn8UyoaFtmM3V8kZxemfrJpob6BB/1Z4J2z4LTmZpwMFv8YTx3gCvSlX5rvE9XMNUQTpjEJGOjByS/KsVznan1qjFqRX0NtRtJ1wfUPQiTLeqpTfcYsR8im7LnYM6ZrqRqF/m1GrCFBsRnxiwZ3GCKXD7adooxBoZ1R7jv8JV7PQmZThTSkvh9MC3Isgv7LVWwSyDBeGE4pQK7a8Q95RokBWWT+tTtrhyPbf79Gnk+zivzQ8lHNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQsue7xvDuF/RYaC/HbL432kqd6TLKdpUDWiT5ypsLQ=;
 b=Oi3ihLlAqQProqzd4daLv6QmFroLql2oKQMLPbouAeBYwqfWDLcPEqdjAv6TGAp6Gr4sKN/it/k+FoSN497ypjmN/nDn6kZE7eAtK7VARv3Kwnnluw7GtD12527zIrPdm3/JvDu4MnPg2NzAtSjgvmbmuEqD6G4ouBLvoAiZB/1ucj17tm6J2IFZI0moiFXQj/+Nsoha5qE0apkhLRlMjc3Ea/tH4L6AMhI4TVl6Ws2cdzPqTy885X2eRCHOvqf508EGJNArSAq7zNtP3RZDe2jlIDRBmVxu/SO+iaHw1AQlLAgRON04W4hKyy1oU6m8PwugQ0ZV9Xl/64d//vmt6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQsue7xvDuF/RYaC/HbL432kqd6TLKdpUDWiT5ypsLQ=;
 b=ThGDWFfRoL6ZFtjjyojhlLTzg0Gox23R1B2yqrVLOHaO/DrTsdiymjRb3AgG1ME2zKLlVpDoq2BylAfK/QaLenxgruU7E0xf4rEKq1vDoJ0duzyvWLyvT/kFVr8+a3+ULK3LgWVqCZOleIqUAToOcV5xJvOe505Qw6krnoVZGB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB7230.prod.exchangelabs.com (2603:10b6:806:1e5::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.11; Wed, 21 Jan 2026 22:57:32 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::46eb:64a3:667c:c1a0%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 22:57:32 +0000
Message-ID: <4c98a1b2-6215-4e71-8bb1-eaeb1722e7b1@os.amperecomputing.com>
Date: Wed, 21 Jan 2026 14:57:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: mmu: avoid allocating pages while splitting
 the linear mapping
To: Ryan Roberts <ryan.roberts@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 catalin.marinas@arm.com, akpm@linux-oundation.org, david@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
 chaitanyas.prakash@arm.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, lorenzo.stoakes@oracle.com, ardb@kernel.org,
 jackmanb@google.com, vbabka@suse.cz, mhocko@suse.com
References: <aW5p1ylQBNXTEmmq@willie-the-truck>
 <aW6hISBu3hNYS771@e129823.arm.com>
 <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
 <aW9LCX92T9t8iDco@e129823.arm.com>
 <baa46ea0-737b-4d9e-b4f4-2eee1476da95@arm.com>
 <aW-k_D1Q8jpYMPoI@willie-the-truck>
 <a6c1f21f-43e4-41d2-adb6-c5f9985b3abd@arm.com>
 <aW+t8S1LfwX3LjRi@e129823.arm.com>
 <11a01f4e-9ae5-4001-9f9c-74a746f898cd@arm.com>
 <02bb61cc-f0be-41e5-b8b2-59768afd5254@os.amperecomputing.com>
 <aXCPHaylUbRJ3CME@e129823.arm.com>
 <ee2bf4ba-0121-44dc-a465-4c186dc18f19@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ee2bf4ba-0121-44dc-a465-4c186dc18f19@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH1PEPF000132E6.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::26) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d00848a-2e27-4e01-b610-08de594075aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akMxbERFWVkvakovS20rL3dVUk9PRnZVRWR2eUhDeVI2eTJ6UUw1RnZHOFRt?=
 =?utf-8?B?dzNMZmFaY1ArR3RLWDFJOFJ1SGVMb0pkVld0QWkwckxUTnZ6Ykx0WmQ2WFli?=
 =?utf-8?B?RzgwWXY4eUFBanN0elBmRWRBMEk4TmIydkNSbVFPQ0MweU9qVHQ2WUxZSFJs?=
 =?utf-8?B?Zzd3QW1JODVxRXJhZC83THQrUmNQbUJhTGQwZGwzVkFGTmVwNDRDRS85V1U1?=
 =?utf-8?B?ZHE5WTkxYVJobnhOVFNMd2hJVlB1bmlCT2lUeTU2S2ZjaFBpOVpwN2FqN1Jm?=
 =?utf-8?B?NmtXUVp4VVRJR1kxN2xBc3h2dWlya200bHNmSnR4MFJvOTByaGd0Z0FYS0E3?=
 =?utf-8?B?aVBtUVFNc0Nhd3JodlVqK0tTQ3JldVhxalBOdmFubUd3OXhLS2lTR21UZWYz?=
 =?utf-8?B?TWdNOFZ3OGJ3a3Z6OW1CcnhWUVFWcHZWOGlrYVJVeXhrZHJuOTFNTktmWjNp?=
 =?utf-8?B?K3Jxbnd1QlV6czZaT1hYZmhJVDV4c2RUeVRialJFYTBRdUR6RXoxU2FJckMz?=
 =?utf-8?B?a21TQTliS2lMTTBnSzN5bkFvVXRZNHFLbVMzK1hxbnpSVStrZmNsMTk3SytP?=
 =?utf-8?B?SlZBcDRSbEZuMm5ZK24yV0RWSFdPRXFiL1RXMmRoNHQ5L2hjS1BUeVFZR3pK?=
 =?utf-8?B?c1g2MmVGS3hIZEdJQWFRUjFTN1BOYkd4anZLMGl4a1NldUZTMWRsTVJ3N0M0?=
 =?utf-8?B?anovOUh1OFJqVGVkY2FXMzdQVytvSGphYXBsVzh6b2M0Mmk5ZjBEZS93Nlh3?=
 =?utf-8?B?YlRQSWdqQXRmcHFwS1NtQnV5SHN6Umw3dzh4Yk16ZElLWTdvMmtMWlk3TmFJ?=
 =?utf-8?B?UVR3K3p4NnNMeXIzSjRDbjFUaW5BSkdGTFFrQzU5NlZHZWJRc1E0eG1waWt4?=
 =?utf-8?B?YzZsZnZzNGRTMVVyaHJYbzljKytVOXlZRDR2Nk9YTi9RaXhoYXdsd2lCOHha?=
 =?utf-8?B?a21oSnZDUjhuWEd1LzVOajIyS2xZYnR0Smd4K2lxNjBPZjFweHVrbHZVWHNy?=
 =?utf-8?B?eFFSV01IMVdpWVNoSXZYaW16RDRRNDJEQmd0Q2NWOGQwWlZtaW13MEFSa2s3?=
 =?utf-8?B?NGdjZ0hNWDR6YUt4cytoS0UzdWd5LzV5cm5DcG5YUTl3VXU2T0IxamZGWVFF?=
 =?utf-8?B?eFBpRDhUMDNpeWVnV3J4aG13RXRWR0Q3bkN4MWlnM0FQQkJqdE0zRW9kemlN?=
 =?utf-8?B?TWJrb2JEcFFIV3JndmVLY3h6NzkwZW5jSXI1OVlGVkdiaE0wYm5LY3lqdTFu?=
 =?utf-8?B?akRKSFBFTFM4TUV2dE1FbTh4TVpIV1BEOURvVUdyNXU0ZmZ2QmlmZEtlRWtQ?=
 =?utf-8?B?RkllNm1NL2U3UTZxZ0tIMHoydXdZQm1kVUlsckpwV0FNQTIvMURIeXNwaytt?=
 =?utf-8?B?QkFlakRSVmcwbXNWUGFUZEJGMjlZZitlamVpK013b3NsdEpkL2hqa3VRd3hE?=
 =?utf-8?B?SDAyNWtEWWhKNHE0ZDRickd0TFFrWFlyOGplSWxkSGdMdGVFeFA5WnM3K2FI?=
 =?utf-8?B?YVVvWDAyWUQ4WHB3WElKeGNubDBqcVhUQXp4bFFtTTNEK1Njd3hXWnZaT0hk?=
 =?utf-8?B?LzZ6YVp4ejY3alduVWxESVlWbUdubEw0MlZyM1FPUFpONnpsREtkT3hQUFA5?=
 =?utf-8?B?Uzg3ODlvdTRQRnJBanNBU2ZPVkV0aVgwaVYzNHRPRGsyMjMxeFhrRkZKK3Rt?=
 =?utf-8?B?OHNIVktxK2RtbytIVGtGTkpHK3VLa0V5YWNrZlpwMWZGak9qRE95bzI0eVdt?=
 =?utf-8?B?c2FyTXFjQ3pQSlJTeWxrakFsUDVCcVZoUTZFY3JNOFBUR2dlc240QVdPWWNM?=
 =?utf-8?B?VXY1VHVlcnYyMzVTQ09hdkpSZ2J1ZzU0dWJoREp5MkZxZ2dEMkkweXVrc0pl?=
 =?utf-8?B?NEVXV0J4OGcya0ZzMFNZK3J4UmN2aWlmZWtlOGcrY1RjcEQydlVkWHZ4aUI5?=
 =?utf-8?B?Vmc4YTl2RkxxZGdMQVMvdjkyVkZ4bndTajJzcXJJNDVzb1FOOUwreThjS294?=
 =?utf-8?B?L3k1TFhuRlBobHhjTmJ1Qjh4eG4yZjZ0dzQ3NFJtTnJiYk85QmM2cXNNTWRx?=
 =?utf-8?B?ZnQ5UUg4YUF6WnJybmlGVjVEelVockpjNVlHTng5Z0orRXNWN2MvLytmc2kx?=
 =?utf-8?Q?Aj2M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFU5ZkRMOTN6U3BCQUFYSEdwSVMybHNDbUNuUVA5RDQyUy9DaWgvVGhRZExo?=
 =?utf-8?B?MzAwTnFwUVpuc1ZPd2NZT2hSQzcrRnhzbXROckNEbEdpWHRQVXVScmNtODdF?=
 =?utf-8?B?WkVpZ1dhSnQyMVlSNEl6L3lvZm4wRnZvT1h1WjZ4aDJTZWV2ME9vVkRpM2xo?=
 =?utf-8?B?OFM1WWhKRENNY041SGxnVkJ1bXRySzc3Y3ZXMzVubnczRzBJQ1haLzZROCtI?=
 =?utf-8?B?MittODU5SWVSNXZqdXVhWHFPTVFpcy9QbDQ2K3lMb0poamRpY3FtUTEzb0Q4?=
 =?utf-8?B?c2NRdUsvb0lRU3NKK0QwY1ZRTWJUV0lJN05Ca2paN2MrZ3NJQmt4WWVzZlFa?=
 =?utf-8?B?bW9aSmRORnJBWUdJdkN2SVhsa0RQTDl6OEtYSmN5Q29ub3kzd2d6eWRTWmhz?=
 =?utf-8?B?UEE4SFh6WGdhaXhiamJWclF4d1BPcVRnSmlmUmZRS3Y0NmxDQnduYW9tREs5?=
 =?utf-8?B?UVpmMVgzTWlWa0JCSktqTXpPbDUySU5zc3dNWDRBdERBZCtPazhmc2U1OTM4?=
 =?utf-8?B?N1pQeFdsMEQ4TFl2bUZHTWI0YWJ5SmMrWEEvRWR0RmpsQWVXRTI1YUg2alBL?=
 =?utf-8?B?SGRIWVErOEpQYy9YS1lVelIyQk9xMGVwOVhDc2xZWi83clJuWGxSN3FyclI0?=
 =?utf-8?B?UENxWDEzQWxRSDUzYkYzUWhvMHptRnlzMU9IMTBoOVU1dXg0YVk4azgyWkxZ?=
 =?utf-8?B?SU1OYVV1S0JQbVZpVnRYNllzeW9KV3AvLzFPSnBHV202RXZUVVZ2a3JqZnZZ?=
 =?utf-8?B?OEZJbzZpWUgwWG5TWXpsbytRZnpQZU00c1UzU3ZtVjUzTnNXWkVnS0hJTitN?=
 =?utf-8?B?RUlCL1U1eUpUR3ZuQUR1eXFiMG84K215MllWSTZqMTV0ZkIrL0VhbEpSRUFW?=
 =?utf-8?B?YktTbmR4SmExNFgzVjlJWTBnM0FmaWIrZnkraDlJVHpRelNLRXNTL2dWUFU1?=
 =?utf-8?B?SVRmQSswY05QLzI0bFB6ZTJ0UXZ6VjVvcHRvQTlhMDdOdDRxUnZENm9OcURY?=
 =?utf-8?B?UXBZNHQwelYwZ1V2Rmw2WUNvVVdwdEQxaGVhZlFuVUcrUWl4VGF1aHhhU0hL?=
 =?utf-8?B?d1I5aXIwZjN4UGJCUXAxdHQzV1IrQlh3cFcyN0dMUjg3QUR3YkJWSituaFJr?=
 =?utf-8?B?OUxHZFRwcy9XdUVrSTBka2hETlVwM2xRL2ppR0pmNWY4OVhBZlVWc2w2K3VC?=
 =?utf-8?B?eTBDWUFtZlI2RHg4TUw2YUxESVZCYnBzMnlPa09CcWhiRjhJTDRSV3BBT1p5?=
 =?utf-8?B?L1h1VzUwK2l1Vno4RnpSOWFjRkJLZjhvRHlzSVdkVDdaN1dGbnorMFZLczRv?=
 =?utf-8?B?THE2QkJ2eFRjRkJOejRuWFdWV3l2cDUrM0lTVUVZV0twb3NkcExFK1JyZ005?=
 =?utf-8?B?eUhHQnpjSldtOEpnS1hWZm9KRzZZelpVbHI0K0pmNFQxdjVLU2FnR3FwTTBy?=
 =?utf-8?B?NmpkQ2dRWWxmTjZRSFROVnZkYjNWSjRqYWlocFZMSkpRU3lxT2ZpdENsSjgy?=
 =?utf-8?B?aml4d2NLb2IxTVM5UXhud0NuL2FVSHJCVXZVck1HMEVYZkE4SzJvcldWWWo0?=
 =?utf-8?B?ZFp4NTAvTExEUmRwbSt5ODR5czcrWUJ0OHgzNmpHYjNRNU4xTE11L2hGanNm?=
 =?utf-8?B?R3prbytHR2FpbWxrY1BTbk9CZ090S09CVzloQnpUNDFMQXozZjNzd3FkQ0Nn?=
 =?utf-8?B?WTRuVTZibTU5UXAzajJDVUNRRVNnUXhMNVhGWFBUamtXTjhJVFpTMEZNemhK?=
 =?utf-8?B?UXZsZE1FNSs2RVpsOXczbFd2V3NGd25zRHphSWFFTGJlS2puZWVDWXorUUZt?=
 =?utf-8?B?N09LaVVnTm5wWDcyY1IwUnhDeFlmZnBoWVoxOUUvVmhta2RsaTZjSG1tK1ls?=
 =?utf-8?B?QytxcEJKcjdINjdjb0tFQ29SelB5VUdmQWt2V0o0ajZVQzIwS3lxMDBaS1A3?=
 =?utf-8?B?MHRLWXUyUE5RU20rRmZwNW5Nbzg5N0xVbU12MDhSWkdLNnNyK2tadDltbFFx?=
 =?utf-8?B?RXlKdUVBL0ZuTzd2djA4Z0lUQjdqN3ZzbGlFd3ZEWnVqa1BPQlFpZ2NDa3or?=
 =?utf-8?B?Qmc4aUNYSFhCbGcwZjFBRHB6dEZWK0xqUVdVMTdTWnhqQjVFUFFLZkVrRER2?=
 =?utf-8?B?Qk5BME1oUHhlSFlOdjJyQ2MvdEsxMlZBTnlGUjFHZVcrR3RwNlc3Y2d3Z0Js?=
 =?utf-8?B?RUdmREIwRGl6TDE4YVhoeGR1QUdPMmtZVHBBWGJWVDhlTEgzTlp4ajU3TXNk?=
 =?utf-8?B?a1RlMk8xZi80Q3ZvVW5nZHVLbHVYeUFFVFVONTNPTkJYMzV6aVRGbnZsaWZh?=
 =?utf-8?B?V1NLMy9OOVNNeXBuRy91OWtGR1paSHRiM0c4V0tQTUZsRDdMcDVVQmMxU0NS?=
 =?utf-8?Q?R375HoV724yGJ00g=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d00848a-2e27-4e01-b610-08de594075aa
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:57:32.1187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WK7EFTpIqhYb9X4zhwybKjTc158MRd3rP+8zGs3KmVK4HEzLVDTE4ECMCtN4+CHQxH8Q8wZnRwMhuYH9qKUBtThTMhm4dOvMPSVKuko2dKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7230



On 1/21/26 2:20 AM, Ryan Roberts wrote:
> On 21/01/2026 08:32, Yeoreum Yun wrote:
>>>>> My concern is that if a secondary CPU can race and cause a split, that is
>>>>> unsound because we have determined that although the primary CPU supports BBML2,
>>>>> at least one of the secondary CPUs does not. So splitting a live mapping is unsafe.
>>>>>
>>>>> I just had a brief chat with Rutland, and he agrees that this _could_ be a
>>>>> problem. Basically there is a window between onlining the secondary cpus and
>>>>> entering the stop_machine() where one of those cpus _could_ end up doing
>>>>> something that causes us to split the linear map.
>>> If I remember correctly, split_kernel_leaf_mapping() does call
>>> system_supports_bbml2_noabort() before doing real split. So we basically
>>> should fall into two categories:
>>>
>>> 1. bbml2_noabort is supported on all cpus. Everything is fine.
>>> 2. bbml2_noabort is not supported on all cpus. split_kernel_leaf_mapping()
>>> just returns 0. Kernel doesn't split page table, so there won't be TLB
>>> conflict issue. But the following page prot update may see unexpected block
>>> mapping, then a   WARN  will be raised and it will return -EINVAL. So the
>>> worst case is the caller will fail (IIRC all the callers of set_memory_*()
>>> handle the failure), and we can know who is trying to change linear mapping
>>> before the linear mapping gets                    finalized. AFAICT I
>>> haven't seen such WARN yet.
> Ahh good point! So this isn't quite as terrible as I was thinking.

Yeah.

>
>> Thanks for the great detail :)
>> I've missed system_supports_bbml2_noabort() in split_kernel_leaf_mapping().
>>
>>>>> I'm not immediately sure how to solve that.
>>> Do we need some synchronization mechanism? If the linear mapping is not
>>> finalized yet, split_kernel_leaf_mapping() will spin. For example, something
>>> like this off the top of my head,
>>>
>>> DEFINE_STATIC_KEY_FALSE(linear_mapping_finalized);
>>>
>>> Once the linear mapping is finalized, we can call
>>> static_branch_enable(&linear_mapping_finalized);
>>>
>>> In split_kernel_leaf_mapping(), we can just do:
>>>
>>> retry:
>>>      if (!static_branch_likely(&linear_mapping_finalized))
>>>          goto retry;
>>>
> Yuck... But I guess it might work as long as the primary thread never does
> anything that would cause an attempt to split; otherwise we have a deadlock.
>
>>> There may be better way to handle it. But this case should be very unlikely
>>> IMHO. It sounds crazy to have such complicated kernel threads run so early.
>>> I'm not sure whether we should pay immediate attention to it or not.
> I think we need to figure out if this is actually possible. We bring up the
> secondary cpus, set system caps and finalize the linear map in smp_init().
> That's called from kernel_init_freeable() which is called from kernel_init(),
> which is invoked as a thread pinned to the boot cpu.
>
> sched_init_smp() is called after smp_init() (i.e. after the linear map is
> finalized). I'm guessing (based on the name of sched_init_smp()) that nothing
> other than the idle thread will run on any secondaries until after
> sched_init_smp() is called? (I'd be greatful if anyone can confirm that).
>
> Rutland suggested that it's probably too early for any PM type stuff to be
> running in the idle loop, so based on all of that, perhaps this is not a problem
> after all and there is basically zero chance of a secondary cpu doing anything
> that could cause a linear map split during this window?
>
> I'm inclined to leave this as is for now.

I agree. I don't think this would be a real problem.

Thanks,
Yang

>
> Thanks,
> Ryan
>
>> Thinking about it again, I’m not sure whether
>> it is acceptable to use a sleepable synchronization mechanism at this stage,
>> like split_kernel_leaf_mapping() does with mutex_lock()
>> (even though it may be technically possible).
>> It also feels odd that this function can be called at this point in time.
>>
>> If this is indeed considered problematic,
>> I think it would be better to simply return -EINVAL immediately
>> when linear_mapping_finalized has not yet been completed.
>>
>> --
>> Sincerely,
>> Yeoreum Yun

