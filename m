Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.92
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795009212;
	b=eEdu6d8DVMi73lIeQa2E+mW/05PTalaQ8i5BtgLl0oH4OgwsdgFfYE14+I6J0T9pJOqy
	 FV9JgNCWKC1+l8Nd2kCqmiFciAimaaE86je//SL6y/boxNy22wgbk2JLqqDNFeH6P25J9
	 rpJioo92yhhOadHcVPker+uN72KQXF18lQ2Is7IEbvP0euAqeHJ8lg4VQbXuZjObtSgSX
	 A7KJmVDE1BEgkw26XR/5mw3Oo5DWxPl8LRnu6KoSSZFMyqJGnFP5z6TzPeA8wQeCe1lvO
	 sjJb1rbukHVbmI9feEVGJzvjkAXc9Bugzp7enONGua6IJaOo6P227NwnuTQDHQwuMmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009212;
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
	bh=aH9g6ul7kNFgsEOg3fP1RgYAMNBi1jT5hjE9AQ1Q5/M=;
	b=v8yttntbwt1sul+tfo6M+xrpCh9y3Sp4id34UMQ72ofjGJUON3G1SJdE13dpyi2+UPf/
	 VIq0/8nPP5sbxk5BuLQR8o3KerJSlI/+vE5NyrcWqkBLkEGMVxv/yFVfWIeO2ihdM89RQ
	 NHD4+ZSy9s35x3fLK+l8a6QHPBL5j8splBRxBAJahbOb654YWCC+gFpaMLnKYHsAOdQBW
	 QYga/FK3no6qiUBn25lfRnVdPHxQ1ABcP5I9lPg/gm3g8q+yF05hide/dhQkD7kHyBiww
	 6JMlc8PGQ68vHH9gQgZxC/Cwz0rHzwWZ/hDNjMDj9iAXj7pecz+Dxb9HVXgE/48/UcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=hpRi269r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.92
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022092.outbound.protection.outlook.com [40.107.193.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A07606A320;
	Wed, 18 Nov 2026 13:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00A07606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=hpRi269r
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVcCANJKynyuPyHsWc+orm0UF9deYkKKvmf3jaa7USrZ7OL3s0JE+ghfgF21O5SMgWIkfsGd2hAKCwG82h7fWXEOjEHFiEWpgBFMBRR0d4S/QZXEO0XINkCp1VGl/cwVGAc4wCD+OEXlZCbMOITzQ+FRNoODtVro1CGHnkOT+kvgE5YW8RRFKl9WMNdDiXBbnB3uRESdYACefzLxcqngvpoQ3/kZ4HbnmKZPfJwXMFxj2HFechMJ8EackxXgoCK0wNVJZibVoQMCTCopCCqS4jx2IsD4PqZCApAGXd/aqvfgJsjOylPTK4J8UZXCnItmGKWodktCTSaRMkIm3tOEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH9g6ul7kNFgsEOg3fP1RgYAMNBi1jT5hjE9AQ1Q5/M=;
 b=zRFO5gheRPgxu5Ru/glOv5aFEApJdA2IQvhjl8zgppxoGQi8pMPFLnXWvhJlaOqkV+0LSckXVe8ee91Jp6krjF7IYGRPvMN8PxHRBAkGUesC6IC6urZJJ22YpqBW4NhobtY4cFf6mTk8PI5Nn8pChbG+NNtMVWZgE4nB+DZE7QPgxKrSp3j9zP8+IHcKyhgIAg7UJJs4Sq0bUJN5bavfFsv9vdliWY1BxZeXAY2fw18vGTtfGN5+iFSRhsPufhfCwTC9w6fV28zdues82/+6sm3T0gSPnBZkbGM5Zob/wzftF/lAJZamSrcv6VLlIO9/wvodX/xZk6U8GMKrSjP5aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH9g6ul7kNFgsEOg3fP1RgYAMNBi1jT5hjE9AQ1Q5/M=;
 b=hpRi269r9dgLm390fiFtWDOdxED6L0mlichFKBb3q3cFYEI0Eir8UDzXwxxsYDmJiFRDT36pMooLCu+CzrDDtzUEtubr17+Rx05zqUKTyKdL4TF3R2XA3IczI6fKKhdsRwZOIC+cn6dcbUpi4Rmv60HYc81Wu3tQOfdeaH0PJRxTK3Pc0XCy6rga8YHqw6Lrf2T4uNt3eN3iFtYHow6EtkcYq84wIERXpwYIQEzqZVqSd/7auiLdnfPuiBR1ldCD8pOWvIEUr++A+0Z1OuCFHL/iQBijmZxMF6QAZlIhp+GwTC9/HNAOQ6tggiN4ZznpfgybeKIK0o5CP/F59cOsMg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT4PR01MB842743.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:188::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 13:40:10 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 13:40:10 +0000
Message-ID: <239ea541-da99-4fb3-b144-b145640152ef@efficios.com>
Date: Wed, 18 Nov 2026 08:40:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 27/40] sched/deadline: Move a task's bandwidth to the
 root domain it runs in
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <3292905cac4b511f515b4d353f02a41d747b8015.1794922146.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-219077@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-219077@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::11) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT4PR01MB842743:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2145e4-8d7c-40ca-5fe0-08df45797751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022075727099003|4143699003|56012099006|261026140227099003|261028144727099003|10067099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	MxvIoIOk2gz9x37t7q3VUvs0an/y47VjBNGEXJ+DxWP1PTZlsXUQnU1JKHTn98y5w4P0CeKJI7YZnRPgMl8mfEqlu40t8/BwCu8KYribbx2Sct9PoHBjwN8udXQS8Dcbz8WP/mnAtckzkpKGGD8BIjf41cA6JbnlC6Z+phsWeACK8d+lHD0bDFcR4oksB+qcCLR1Z+AP3EJKIQfGzYjyGqUemBXYFkcN+RNsA2CckclZtIeMSI2QTVcQdmsaOqRtlELiZQQfQKKZR5vPwF1gF7H12HAnLuo0K0/tMuCMKI1vV1YRpcU67BJ3/hnVUm9UNF0PiLDz0AnUAaAddXyCMS5pfTJmrXhCaWjrEBoCgkjnT1lQc+E/+2Mb/GnttwhmYbpbPpqQFnPTXwy0nm4lb+qlCVlld1CezsZ4i3HigG1fXOrgmroSdtU2Y1XQTLCyMPGXPEDPdA/nbxbBRY7Hg76ck0ix/ULSx7n4ZP1aHuNt4QnVffxSoghWZc439mn44uSAZ2JoxzBlG8z0uWhtn0C0tJAwfwmbQP4VDIyUtUTHEyRmE2bRQSVCitJ3QQv4tHly0QUSO6JjVmBki3qhmvSMfp6YtBzvHEvg66rNShw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022075727099003)(4143699003)(56012099006)(261026140227099003)(261028144727099003)(10067099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUpCY3podUJhai8zUThDL0NndFljVGtndWw1N21SM2JWWFpkNWNkNEJvOUl1?=
 =?utf-8?B?OEtrTi9SMXQxWU8xbEg1ZElHUURlQllsWDFtamQxOVdTek5FdEpSdzBnZU05?=
 =?utf-8?B?cHAycmJDM2xYVVloMDFwL0tPOTJnWkV4U2xkZ3U1SXFEWmpocXdPdzkvOVFR?=
 =?utf-8?B?TkFGT2ZYZU5PK3l4Y2dLMVRmaU4vZDIwRWhHT2dPOWFDUS8vYkxFbCt6VW50?=
 =?utf-8?B?RGdFcUU4NXVDT05KZW1TMTc3UlI4c2JVaFpYYXVwTXR2d2Y1anBmTW8yT2N2?=
 =?utf-8?B?YlpWL1lJOUhtRU1tcFZIRHBFUmZMZjdHRTZSZGFpdnFGSHZ4TUUrQ2thdHNv?=
 =?utf-8?B?U3FoOXhVcDI1V0Q3U3JscUI4cVhZSkFFNFF2ZmNsMW5FclhOc3VzM0JXUHQ3?=
 =?utf-8?B?RFhtRERPdHlRaEFCYzBuVDQxb2tSdk1aejFZZUZ6NUI0UG4ySlJFdXVpeXMr?=
 =?utf-8?B?endwOGx2UDZDanVIUmE2VENmajlCeGh5WEN3SjNPOWI4TnBYWEgxcFBqb202?=
 =?utf-8?B?SFM1eDFqSkdOUDhPcTMveStkWVlma0hyam9idFIvMVE2dUhzQWFhaGRLRE9D?=
 =?utf-8?B?TkZWbTRUVnZTWnBiTXBPSytoTVhoOFl0SXp0NHNBNFM0d2MrU08vM3NObit1?=
 =?utf-8?B?SWFPU3lqZDh4SmRjbU5veDJtK29FUE1ONFh2WE9HZkt3VUd6a2dlWWdkb2Rp?=
 =?utf-8?B?cnN3MW4wb0xJZ2F1WVFBblFrRmdvM2xIVm1NMnNuTTRJdnQyZndaZlhxTjdi?=
 =?utf-8?B?dmd2eEJ6UFYzTEZvZ3VvcUU5VlVjRzhvMnN1YXAwTktrL1E5K2thQXBGRU9T?=
 =?utf-8?B?YTBzZW9wV0dhRHRidXp2eWU5Z2I2NmlDemIwZ2dWakxFS2tMTWxaclFZSm5r?=
 =?utf-8?B?Z05JZzZPR2VqQ1Rhd001WWRCTEFUMnhFMFlsUGhRTHpjOWZuVHBpMzlVdkU3?=
 =?utf-8?B?S0NRYjI5aGhnYlFad3JKZWlyNHVjQTZFR0xHN1RuS2I3bGVtcHhmbkJNM242?=
 =?utf-8?B?ZzFDQ29uYVBqaVBxb1JKMnhhb3JrenZSN0FFVnh5Y0N5bmFNVXk1NVFvdkZC?=
 =?utf-8?B?akpBTSttcGhPVEU1dFNWZDRqd0JnWU9lRkNUc0FBNkxuc0dBbDJCVXpLNDVP?=
 =?utf-8?B?STM4WDIzR3ZVY2lYN1A4TUM4SS8xcXNETmtvUUlWWUxtUmdmSFp2eWRCZmZs?=
 =?utf-8?B?bU1nV1FIeUlmc1g5M2xac056eWk1Y0JuQStyYmExOW9JWVJycDBWUWdWK1dP?=
 =?utf-8?B?SWF4UjhZVjh6N1Q5SU1ib1VpNy92Zys5YzNPQkNvV3ZpaHRDemtJZy9CZFcv?=
 =?utf-8?B?VmJDRVdHb1hGN2lGY0grM1VDWXFLbnhHZ1RQS3AzYVJvMDFUcTE3S200WlNN?=
 =?utf-8?B?VUhZcDg0WTRwTE94QXIvR0FnaVZIdGMyUk9sMzNYV2o3WWpaeGRaWFFPOGV6?=
 =?utf-8?B?eHl1TVJkOGM2OXRLbzJmWElCcmZ1WGhSdXQveE9uMmFQRThsMjJKenh6NDVN?=
 =?utf-8?B?WFhEZnJBbUR3QnBkZFpwUW1LbmNFWS9EdzNnbmRrdHoxcXFnc0ZKdmlGK25U?=
 =?utf-8?B?amhXUVZvWWk3MEJGWkd3NzlOM0dDWG1FaURjcmVzMFN3U0VsRSt0dXdscW0y?=
 =?utf-8?B?VVdTMmlQYjlhL1Q0UEplRzZYV0VLQkNYS0NZSnAySUk1NUF2TnQ5Mmo4U1lk?=
 =?utf-8?B?MzBwOEdNclFxK3hYUjRwQm1RUzZTcHRzQjJEdkpqUFZoakcvNkY4OW1QWDF1?=
 =?utf-8?B?Sk8zNU1WVU5BU1JhQnpYbHBQRWxiMW12bUMySmtTNU4wVmE1cVFqb0VJcXk5?=
 =?utf-8?B?WEZVRkNwSk9rcGExeHFHSDVybmJEdm1sSU9yVXQ3SkVoeTdtb0lrOGoyL3hJ?=
 =?utf-8?B?d2lEOVFmTmFkMUpHVWJ3ekxNVXpyeVkyek1ISGtDYXBnQk0xV0JiZEsyOFVB?=
 =?utf-8?B?bFQ4RzgyT2JJTmUrMlhhTSt6MGZNbjZDUlFXeE1UMHNhLzJsSG9VOFdRTW5T?=
 =?utf-8?B?WGJwZk5ZQWlZNGRodUtjTk41b2owbTliVjVlcCtQV3RyWkJnVU1BSUthbjY2?=
 =?utf-8?B?eUhaRUxOV01sNWlFMzQ2OFdHZEQvMU5FYjZKMWZtdU4zdFVXOU13QisrUmUr?=
 =?utf-8?B?eVJwSGx5TkVkWFByS1poUE1kZGN0bWxTQ3JjcDdNeklKVW16RG9zK0ZhaWVr?=
 =?utf-8?B?L1h5N2pJejZzTFhCbnNTaTVzV0ZCakR1dk9McG5PUEhKNmN2NHhvRFpyb0pv?=
 =?utf-8?B?bW91QUVrY1ZWYXg2NTU0RTRDR1NIOFptWHJnOFltYVlTbnVqR0lNUVkzRU1P?=
 =?utf-8?B?N2xBUjBDbFVTR2xnaytVMzRHdTJPVkFXVTNwNmJLQm5hQmV2dzkxVjZEQ3VM?=
 =?utf-8?Q?3SHczWcjTx+IANHiQ83aRyXX42zy4EcoyUWwP?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2145e4-8d7c-40ca-5fe0-08df45797751
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 13:40:10.6002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNIWHfDLR+0KrssHbyKSs0Qu6t/JIIj5BUYqFvDyGezkZJDF3ZVlaW5LzLRXIntWPk8fczaijKFe2bprIl0O1c4G73tJ57df3Ek5QowTxNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB842743

> Can dl_task_move_bw() move the departing bandwidth of a non-deadline
> task that was PI-boosted back into the deadline class?

Yes, and this is intended. A departed task boosted back is in the class.
A rebuild counts it where it runs, like any deadline task (see
switched_to_dl()). The move does the same thing at the wakeup.

The bandwidth is moved, not released. One root domain counts it at any
time. If the boost ends before the 0-lag time, the task goes back on the
departed list with the new record. Its inactive timer then releases the
bandwidth there. The move has no check for room. That is a known limit,
which the cover letter lists for this patch. This was checked by
reading.

> Does skipping dl_task_move_bw() when p->is_blocked &&
> task_on_rq_migrating(p) also drop the bandwidth move for normal
> queued migrations of mutex-blocked tasks under
> CONFIG_SCHED_PROXY_EXEC? 

Yes, thanks. On this base, proxy_set_task_cpu() does not call
migrate_task_rq_dl(). So the check guarded no proxy migration. It only
skipped the ordinary migrations of a blocked task.

With admission control on, I found no such migration that crosses root
domains. sched_setaffinity() must keep the span, patch 28 keeps the task
in it, and a cpuset attach moves the bandwidth itself. With admission
control off, sched_setaffinity() can cross. The bandwidth then stays
behind until the task sleeps and wakes, or migrates again.

The next version removes the check. It stays in the proxy execution RFC,
in the patch that makes a proxy migration call migrate_task_rq(). That
series also wakes a blocked deadline task through the full path, which
moves the bandwidth. This was checked by reading, not reproduced.

> Can keeping dl_bw_rebuilding() true until the end of the tasklist
> walk drop bandwidth moves for tasks that dl_add_task_root_domain()
> has already visited?

Yes. The message says the rebuild that follows counts the task. That
holds only for a task the walk has not reached yet.

The root domains are final once the walk starts. So the next version
ends the rebuild window in dl_clear_root_domains(). A flag,
dl_bw_walking, then covers the walk of the task list. A helper,
dl_bw_move_blocked(p), blocks a move in two cases:
 - the sched domains are being rebuilt;
 - the walk runs and has not counted p yet (p has an old dl_bw_gen).
The walk then counts p where it is. A task the walk already counted
moves its bandwidth again. The walk and a wakeup both hold the pi_lock
of the task, so they are ordered.

This moves the boundary of the known limit of patch 28. A wakeup can
pick its CPU before the walk reaches the task, and be queued after the
walk counted it. Its bandwidth then moves with no check for room. The
cover letter and the message of patch 28 state this.

> In addition, when dl_task_bw_elsewhere() runs under rq->__lock
> without p->pi_lock, it reads bw_cpu = READ_ONCE(p->dl.dl_bw_cpu)
> before checking dl_bw_rebuilding() and READ_ONCE(dl_bw_gen)

That lockless test is only a hint. dl_task_move_bw() reads the record
again under dl_departed_lock. A stale read can only skip a move. The
next wakeup or migration tests again. I left it.

Both points were checked by reading. Neither was reproduced.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
