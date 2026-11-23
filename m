Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795442355;
	b=f5kwUWIsq/3+MsT8zHggexGUDola0S/oHq3W9P6L8TWsIqW+juUFJ50bPyQtGyFSBK3D
	 GbVxTz+RBtS9GX42zI1eYa7cAxFJ3q6rIOCJQmAL3WY/0nIDAVXM2HWSD4/toQjoo1ep1
	 aeBuN313ch5NAvzy1vj1dIXFmiOGr+isGn80rORheEJTDGNJbzv4/br6QsFUBLfbqnL2h
	 yRVG6O0hkeITc5S/Jchoyt3TdFHW14dYOHAH55bahk68exB0r41QF9PfPWPuCggAb8jFj
	 xLvmlkMh62y0s26TKJdcAgyNFhjuy7PvEoNpA2nxdRp+nGnXCnlLvMDssYT8tkvoMcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442355;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Uvu4xNFvKUul6V6XE32j0NfrmhEEBgqK0k9w88VdGwc=;
	b=CPxdLiWfdZuWAIyZZmetrMj8vcNPkUp34UiCvA898yObuqGcsdLvE5sKOZgkPmWAKlS9
	 kdL+c/s+2YOKCaEutsSau3lNUDKwUyimH96zcP+v5gy41gBctV3QbtWxHBg5MOdkcbVM7
	 gQegrVSYquj075/lrlna+ZhWEMHmRxwVHMbmhEBiIk00fi7/9TaYkT8/A4lczqBRnNmWQ
	 qDhEAQJoLkR9/2YAtwtUKDscHs/dFMfiJ3ioCbTcN+r1yYdoDLgJXCS+WZcSV9V4KEbHf
	 tImV6xgiP/vW1zlFvm8Rwij/5yneaz9JpwsFVYJBIVBD8pEbIX4jSNXqWgrQ3WRNznw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=PLBOfTXl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.123
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022123.outbound.protection.outlook.com [40.107.193.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC953606A327;
	Mon, 23 Nov 2026 13:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC953606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=PLBOfTXl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0FzRPOmUCXtsgOIMnmJL1jW1dEAG+n/GMcZXgGzhWl6IWPpLpF5kz26TjK1E09LdvVXzPqAUnygWa0Kk3LLXHNjr4da5I6Jr4GPbLlmo4VwfyE6W5uSzUM4Jf6si8kX8qFTP22V+pReDtGrvl+D3HXhBKNIoSWia9OMPkTlaOkYaFNQdAF5891eSM6ahlsd8UYgHCCs14FztY7/kuMVjmrnfmFNo7iDwbm4HE3X2VtKylw9JXyFSYHA2aoH1de/VRXzUklsPv+DusfiX5O5v1iWruagbHfHkCG2UHW8nsmymy9asxrpcjlodajmY83weMjoBRIAAS+x4wlv7NvvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uvu4xNFvKUul6V6XE32j0NfrmhEEBgqK0k9w88VdGwc=;
 b=AsQteR9A5UmR3AvXcqDPm0w/a+0DHtJVDEuIHGUt952RXNTzGptCO8x8JB8ojRqZ7a4FEXnewHgu5HR9HhOxWc0FStwhs2Y7+1C/u8xn2N5ST4K8Z51fPlJafppDQffrGY8AR+fpJ4n5GbjMbrzBfVU4Won80TWFSeomWjtTQjWXEcaSUg+izSH9bbidbwSIXLfB+LZU32BAL4w6v6s2Fc5pNvSM+q7dG+OfO53bpyiiPqpq3gXc4muln73YqjKSNiMDAid+2q/s+hhy3lCN09rUDw4UkOMSwZxhfzGU2ZmVaQkfm6RNPxdMiyn+6siHjcsGQ5Ig+AwRrl5GwNYz5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uvu4xNFvKUul6V6XE32j0NfrmhEEBgqK0k9w88VdGwc=;
 b=PLBOfTXlKilQnGSzambZ1kdRLtUi9HzhN1BAOzYEJqiFPg81SGPhg+AGpaSU9v4QX1omnw6D99mC0DKoRxOnAHUBsJmzHxGW8GHgw/6I8S7UdCWDkuAHKnEkY/SFs7x0vciC2Qe0WOi0qN1L1nsspMLntnTkgD2Hh5haq4H2sU9SutWEzy7GANIUCtb1G7SpNpBaYQhevBD+L99G4mgwNWxoC6WZrkG/U7RBZ+vpZzkMLRTLyJrYD7qgvhe6DY38dHXT+ZXaANgbf4PO/cXeBdy1YQw6L5D5DKpf6UkEfEqmgG6Eu7s8gQ5gkpezhQJqdnX2IjTh9vmKk1U9y5GXbg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YQ1PR01MB201539.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:113::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 13:59:13 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 13:59:13 +0000
Message-ID: <8b6818bd-7a05-482f-9903-a26d65c8efc5@efficios.com>
Date: Mon, 23 Nov 2026 08:59:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 24/40] selftests/sched: Test the rtmutex chain walk in
 deadline_bw_test
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <bd1d884143e64a1d5fc73e8af268af995627dc54.1795207232.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-226127@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-226127@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::20) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YQ1PR01MB201539:EE_
X-MS-Office365-Filtering-Correlation-Id: dbdb6048-429c-4e76-308a-08df4969f45d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|261022105027099003|261026140227099003|261022075727099003|261028144727099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	sr345cAMz2JJWGb6nH2USDTYdnWT+PVDIHB/6AX2Iy7YdDRDuRXHLILrdPU5pGTHGje1/3g74+VW+Hz1cPY84TXnfJu14J3+wYT5n+y8DE6DebBClgAlXsZ+q6w3rKiMor6z8b2lAge2RJuGG0xL6/eiCOMhgU5440GowQ84wUaQP53A3GdAIo7AYoHN+GbR4MivGPoCGs+gtoffzBpijPDeXVbuqoXhRXCjSiTlsFMz3+6zhZsDmbWeZoraV5/X9gIUjY9UquS0Uc2/QFStY9K12vkk2g+7elEsMXxwEsSxXI7pRyGMjmHQD9Wicfp5uhTrWzW8b4c/mDDO9pkSbddQkFmalo1WI8BnpopagdtwoVsgL4JAuuTPxSmUB9Ro5/Sghy8aIb772KpZi0oINUufyvf4UyoinWipDXD23ehMLVTxhJIDGHSwPQW+VxBi+aYHjlKNoGYZafHxd29RBBq/d/hy8hwdFsqBXAPt6JPK5saJm2jVQBFtDI/MOCA4Lj+xSbYPMK/ZALc9gzkGYnIg7SS49zp3/cl9RZMxw6XCC4A8O/6y/aAxwCw5RjMFhNsQok7xsDbGTGLDUqK9UkFogV2H5aWvxbNb436UlRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(261022105027099003)(261026140227099003)(261022075727099003)(261028144727099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEdJRThCS3MzcXUxeExrdzRZWFQyUXhZTi9LNnl6Wm1SNmZMeUtNSU1LQ3lP?=
 =?utf-8?B?YTFnVVVPaXM4UG92MHIxdW9CUEJvR2xvVmNkYTRZT2k5MmE5Y3JYY3loS09H?=
 =?utf-8?B?OUxuRnhlb2Z3ZVN4UWpEZ3lVUE8zR25wbytPOXNpVFV3TzdBaE1YV0hHVG9R?=
 =?utf-8?B?VTdTSjc2VW9ueVdnTmxSNFRwVU0vNHdLZ2tsVGU0QnlZc0RDaSsyVEh2aDA1?=
 =?utf-8?B?Tks2SlExV2xSY0xuSW1UakFud0dvb3A2NXpaT1J5ZWwvdTNCeGhTaWJNQkhH?=
 =?utf-8?B?MkkyRU0wQVBnNGNjMHJJYnZSMXBGVDh0N0JVRzhNLzZqTC9UNktzT1NEU1NT?=
 =?utf-8?B?bnFveXZ4SS9WVk1ZWmRNRjRpTG56cEx4UTAybDJxWEJYZzV1eXllSUh0a0hW?=
 =?utf-8?B?Y1daOTVyMXZpWFVMM29CZ3kwWVFYV205RUhQbC9yeE9HWUpXVlM2Y2RXV0tK?=
 =?utf-8?B?R3U2U3lEYngrM01uRFdjMnBGZDNpUHpRRDR4Lys3UU52NjJUUkRZeis0SVlv?=
 =?utf-8?B?dkV2MmcrY2huMmVZdURtUTRLb3JlRkxwbEQ2VkF5QjdiREtHdDl0UW1MM1N3?=
 =?utf-8?B?UmU5amx2NXZoQjBxRCtFZzBRLzhHTExIQkZYWG1wMUlJQUg2UzZaT1dRbXdj?=
 =?utf-8?B?VFEvTUNoaWhYYk9UbmFKdGM5S2E4NTRxUTVQMjdkRlJJZlVPY0tKMGhpbmNM?=
 =?utf-8?B?R3NaR2piVnZNbnFYSy8xR25nM1ZjVStRZlVma1FVdlVxdlB0MERxemlIdkhl?=
 =?utf-8?B?TVJWelZkVWxzL3M1MHFnL1BETXQvRVNKTGJTNCtnM0F2ZzExeXRoa0dhR2lm?=
 =?utf-8?B?VjNYejFWaE9rTWRLbUFWTmw5Nkx6cjlPeUlRN0l6dlhKNWtzejdYOG5IVGpu?=
 =?utf-8?B?R0RUU3NmanhnME9aR2RiTXNnTlg3eHJIbWpMTWkvUVVpeTBOSkZHdHp3R3Ro?=
 =?utf-8?B?SGEzaEMzaGNlMHhCRHRtNDU5Nzg1NGNpZm1iYVBoaERRTiszMjRNN2tUNmZz?=
 =?utf-8?B?QisyRFFCVEd6TVhJc0JVOXl3c0s5TFFpZXlLRDFIYmwxZXFIbWZuNDM5RzNq?=
 =?utf-8?B?VjVuYUo1UENGdjhSbGlLTFExQi84Um5wMWtKcVNxQTFzaFNuT0hjMXFGYmtQ?=
 =?utf-8?B?MEd1V3VEZ2Q5dlJmVEZuVkZ2MHJ1LzlEc1BSLzh2TVZ6RGFPdFFSNkNYNjhm?=
 =?utf-8?B?V1BIYk5ZY3AyTFkvRHFCY0Q4SHIwWDhZbGV1dkZoUjdJM3ZidjBkdWNDMVNm?=
 =?utf-8?B?ZWJsVWwraDBwMmgzK2Z0YTlycmZMWVp5OFNGNW8xcFRMQlpQamY0MDFhMyt2?=
 =?utf-8?B?L0ZocW0rblpjYTkrbzlrM1JJeXVaREtCRHMxZjFjLzJKRzE3R1RtSTVxK2Iz?=
 =?utf-8?B?Rzg1TUNVd1hvM1R5MndOWjd6OGJjN1djQWZtVDltNkVCMTBDMEMxenlGNWJm?=
 =?utf-8?B?R2RndnhuVXYzak1kbnBIMlRkRThpRmVITW1QWmtEdThFTm5LOTJwOS8rdU9t?=
 =?utf-8?B?MVVkdnpON3VmRkhvV2xYR3puczZLUTFDazFkR1Y4MkZwT2NTUFZMdXVOMUpE?=
 =?utf-8?B?M2xPY0J2N292RDNwZTRPZUdCdGt0TGtVRm9mSHZzeFpIZ0FxWFVjZnRsZWJD?=
 =?utf-8?B?MTZJaFlSZ2YxRlovc21hWVREcjhEamttY3JsRmJBUFNWYkRJVzhvL2JhTFRz?=
 =?utf-8?B?KzB0VnFiQWhtRStibFMyemdUWG5hNjl1NFBWc2JVS1U2ekxVeXFPMDBzYW1D?=
 =?utf-8?B?MmtnR1FITzc2VlBjS1pqbjBaSjBCeUE4ejZsTWI5azUxVWhzRTh3blZWbGhy?=
 =?utf-8?B?enYrMmpFV1IrYjVXMUxMUnZXUmFUUkUxWlRWM1c4MzB2OUFma1k4ZFJnS0NI?=
 =?utf-8?B?WUtGMi94em04MkZZcjJORk9hOHBadmI1eU5peERSRHVIazZLS0pKOHNXcTNR?=
 =?utf-8?B?NWx5akZONVpiR0pMTnh6V2lHUnMxNnZaMERYSFdVcVZBZjYvMVFicE1RSUoz?=
 =?utf-8?B?cXU3UnVLdHVBejVpS3NtQjZrUHVUNTF6a0t3QStXN3dxQTBqWUVwLzk1VThx?=
 =?utf-8?B?d2JqcDJLRjlDVXpBS2Jscm9xT3ZIL1FSZ0M5UnRadjdTeFZHU0tKSjM5TnFr?=
 =?utf-8?B?UHpmTWRDRFRJRnlrcjN3K21ZWjFjSlFzOEs5VkJOZnlCNTlSK1pWTXV0aTVM?=
 =?utf-8?B?WURZYTJ2ZUpBcnpYcnBFaCt5TWFRd2VRNVFJMExtWll0K0FvMDdmTnl6MDlE?=
 =?utf-8?B?OFhrZjBlVEV0WE5zdlF3cm51NlNVcWJaTDVaOEtvOWFQczlHQm45SnhDSXVI?=
 =?utf-8?B?ditSZTgyVmhmTHg0bmpRbU9YeDNmM1pUTjZvcEFweFg5eE1KREEzd0RxZC9m?=
 =?utf-8?Q?iLGaC8rSbed1RxOk=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdb6048-429c-4e76-308a-08df4969f45d
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 13:59:13.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vGky8GG68NPGQVxYClKfGjiQKAHAMRKxsIq4nVr4GJ510QTBvhDh/YjOpwDNxvl+7aw0dlgUHYQW15teXUcDktghD6EKNuYBtLVM2TvutE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB201539

> Should top_moves() return KSFT_SKIP instead of KSFT_FAIL when
> sched_setscheduler(0, SCHED_FIFO, &sp) fails with EPERM?

Yes. In v11, pi_chain_top_moves_rt will skip when SCHED_FIFO is refused
with EPERM in P.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
