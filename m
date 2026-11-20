Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.121
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795182716;
	b=y/8MvSAWDaJb1DedHZqUNe4Oe7K+uCQA9UJD0zU64MxcSqGo4rRzcysxXL4wCa3u7Oea
	 9rFvv4JK6Fw0FOwMflqinQ9pU96+k6Q7qnyBKoc1vqE9P8ACNs+7h0aXhprtiYt/1fH9r
	 Jzy0FrE8HVnsoV7Q4vrZ5uHmXr5X3MthhD6Kw280HwhMVXzzdxddQUR4/NImYyut5YG5E
	 ED/iKjPOpIIroosIEPcRQxlSxqRgS34XLury6gAIWHNavhYGF9L7bu0MMESfsDuaWPdiw
	 Kx+3ILfbpW60IKxpADnsNKet5jw7GpuouPON4592Ts/D5u1ZrHMk5ZlYsyzhNWQIxZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182716;
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
	bh=XBPcBbBpAHpKldz2NviRNEpg4Z0hukoS/Sm+2/qGGi4=;
	b=MLmT7qENxl2p0OU9eL9g9IxnfTBE07r4zO1oTiLwzMC4bXquLnqrJ8k3B6+/obWlub+P
	 O5Z6bJKh4+QInLunH9YA6sk911e93IrJwguzfPEiqx1+kBr1dd4vhVavdjYGmrhEH1AtJ
	 +vDxFrHLoJfC25jPcymHpVYMInMJ/D3wG8BL9tr5KRyZnSH/TNRoREV8yKeKNZgAJbVDx
	 srqgt6dM9mFKLrlOXmlTecvehHl5pZ1pmqDq2aN5luquzZSSiecpWSHiuutTK2CnkHdEO
	 Kgd3XtX0LhfPvDI5CffbM1tfrkQcYkj8dSVZCx+9EqWEr25EbYM/zisM5w7n0pOXWWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b="Kp/AuR28";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.121
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020121.outbound.protection.outlook.com [52.101.191.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65254606A325;
	Fri, 20 Nov 2026 13:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65254606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=Kp/AuR28
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQOtQTSO39lBzCWGEo/7x00k2FWJVQq8EtU8w9ZTjq/okCVlAFcfabTKrsrAHh0Ke3nx97rmvPCpflnCCAxpCiCOhkSlGXaq/pfzfJiV+iv1CG+iC+iUwSmAOdEoQ580p28/u9/u+gUL8TPArCBCYxUrDfnWP3w5U4uDDbBGt3ueDZE5hb+9mR2ePZKCcIIpRY/XRLm3kYvtkZCoG/pPp6BapDTeqhqUyl5xQ7w3gaCthhWCW/ZmxbcmjGZTA9+d50asGJ1fXxp14nrgc3m5+H56Sm7Hcwm3iDNSN4PyCB06Yj8vLZeKTYo0+d+tN3MHEkLofCGLM1mJcFwVCHCoFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBPcBbBpAHpKldz2NviRNEpg4Z0hukoS/Sm+2/qGGi4=;
 b=Qgl2mq3Pb8/R5e78R+GCvP5GnzO1XjL+FYYMOy/lV6sYfVLgSilUjZdOZ6qs9X8/CultW+cpmKIe0gG9YlSeIR3SYrkGLQ18tiEKLZw/LMfWDFSpDkuEXeGf7+DkFzBDE3IzY0VSUUU0rQujjQNWcvZyB2d8DNGb20VcdhMb8o3Km3BcmjZNPRdgXNWEDBX7IuGi6J87MjnuTUqw8uEAYxBVSzPtAr9kTB7/+tKAtPEZIljiz+G0Unzs2C484EBaTNWZUdcKuEAn8ezh4k9pXkwM45usXHTjZm3ZSrHR5hkyE/TKCZJt2p1a22E9KMvkGmFwiH4TmIar0QRygf8jVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBPcBbBpAHpKldz2NviRNEpg4Z0hukoS/Sm+2/qGGi4=;
 b=Kp/AuR28tWPYpaH9amSyAglndgcqxAwp3NNo9F7NZ4WtLv+gFfnAasw9druBBRSN5oh0kExPDbDvsrmFHwtH6sxS6Ll8crG5BNZiK1mLc609LLHMGnMHDomXCsbeTEkBWVeDDAVeN4cz3vx2jQsIH6rutIX3Pgs6ulz12+aHrqby8AjXJGjIc46SLAUIvLXizse/C2CkvVIs1lB+ky+bYkijsTGFDVF9NCpx5OA5EJ8CIKyY2tEUf1rD64/FtyUn+AuSQ7JoG7phqz4a/Qq8fSNEpHyARNe4nBTGtOVTy3Ztd7MQQrFCeUJXvE7NaNOnUKAsJsdzvCOzkvkU63oFvA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT6PR01MB165033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:200::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 13:51:55 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 13:51:55 +0000
Message-ID: <dd15d3ba-2ffd-4287-ac24-6802911be0f9@efficios.com>
Date: Fri, 20 Nov 2026 08:51:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 18/33] selftests/sched: Test the root domain of a task
 in deadline_bw_test
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <55480cfbc5c82f022d2f7c4d1ac721ea50e5dfe3.1795116791.git.mathieu.desnoyers@efficios.com>
 <sashiko-outbox-224019@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-224019@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0263.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::17) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT6PR01MB165033:EE_
X-MS-Office365-Filtering-Correlation-Id: d2171f07-a948-4667-1b19-08df470d7009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|56012099006|261026140227099003|261028144727099003|261022105027099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qn3Ds0bmcfizarYOpWk4NKFDQh/QU30hJ0DWooaqSEeuqDBvzaTDyrK8jih+uVJY8kMExHjPWKkTUPPUVNE7Qzi1a34fJNW4fvrKOJwAY4M1+gM/85S2qhRaP0LzkS8WCLQGthHBaMcW7F2iUgW6aXKoDvyLnU/Tt9fxAIiNKKhRlgNbinTiT4NhU0AahXsxnwi1f633qwSistJFTYJjFmcYrloGdzVPzPFVAS37qaE0HZS4vLkQ0JJL64BLS7fqMzAScaJLbXyTD+0OyVh80jX3/k0j+JUt83c2klRF/09Fgx2yKVJUpvGtpbE+JN7DqadV0aL1Qw40h3zdP7IdDp1AiwobVIjMoDVK12VF2yIQgTyVZe0dG1Vii7OMx9a02/TfN6XNXiipNZW+elzAMV45uWm0xwlh2O2nogmqA8LmEVOl5Fj4eAd2aRMuxppndMEqdvVYadOQdHujpWAc1k6sMNpzNnKUxcDImC0BKIDsaYXeuhEBybZMUtAD75bElqTtzfZq5ubqfSBAmoTdsbz7rNSNPzrDaOTBXPriNzfgvaKD1DQ7GmF50qlcgweaf/8KN7VBkF7eQ3Q69ji5CFPYcdpS5m1C/8s0L+myQF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWhUVG5qRFUwT3F2ckdZTkhHdnExOUlxQ1NwcEhDZE9FQnl0K1NldFk4ZlJB?=
 =?utf-8?B?b1BjdWd3cW1DdDhQdFNBZXZ1SFFjRXpYTUJaVEh0Wm8xeHRZeEpPQlFkSStn?=
 =?utf-8?B?bFpsNUxjdXJKUWQ3bGE3bGMxQjE1ZzRjOXloNkxLOUU1QXdRZEl1NGN2Ykhm?=
 =?utf-8?B?aEhaNnM3dm14dWsralJFNTUwVXJHdnB1MDFJWXNOL1JQSHVPS2FyZnIwRjN4?=
 =?utf-8?B?NUJrZi9IK1BrZTQ1UE40NE9yRG8vWkp1Sy9DR0dYYXpDbVdObkpwS2JKazIz?=
 =?utf-8?B?dXMrUThVcGwzbmRHb3UvSEp5UFRPd2N0SHBOMDRJdGNhOFcyOVJqMUxXZlc1?=
 =?utf-8?B?ZXBwbSs0WGRCUHpYMFVUbGkyZCtFNFhzdFpiaXB0QlRFNXh4MW9yWWZoMkJv?=
 =?utf-8?B?S0MwU0lVcEh2eExXd0kydWZjR2xoWlBoUGlWMXA2ZGZwTzFJMWZMWWFEZVY4?=
 =?utf-8?B?T1pWbkdPRlZzZTA4SXA1bUlTUmVwSWJqenNFWndhT0JVVVEyTFc2Q0N3VUZ2?=
 =?utf-8?B?V0s0NjVBSXY4TjJDTitkWG0zUTUxRDhUaXJ0WlUyR0JjWHpyeTVmbmJZWjNs?=
 =?utf-8?B?M1k1RlFKMFROUkdpYjd1dnluanpvd28yL1diaG9md1dIT3dzY01rMHBzR3M2?=
 =?utf-8?B?cDlxS0t3clFjRGRlWXNyRVNxSUcvamlZbkRVRVA2VFEyQmt3SFowN2x4dU11?=
 =?utf-8?B?UitIK2xQbWMvN2c1eVRXWVV4aXV2ODJxaEN6d0VJeEd5c3Rrd1QvY1h2dnF5?=
 =?utf-8?B?ckpPbEszWkNxZUxFU3RYWUJxSVZxeHBwbzZMcVNnWUs3b3ltMkJCRXk5V0lZ?=
 =?utf-8?B?OHFocE5WQlgzazE4dlE4Ynhoc2s1a2pNRmUzQ0NjdU0xYUo3U0RoeHp4RHdm?=
 =?utf-8?B?dzFsWCtXaEV6TWJzR0VVMzRKNytTanMxcTV5RlZZaGpkWi90NXFTZzFkRkpE?=
 =?utf-8?B?cExFdWRXZXA1amZGQVpVVUx5L0ZTU1NpZG9sQnlwdlZVcEYyQVR3MTJCcFFS?=
 =?utf-8?B?Qis0SUJyN3lmUGJxSGdoUkp0eGlhWFBlcHRDYVJPTkJ3S0o1K3FvazlZb0hi?=
 =?utf-8?B?S1RacHBiYnRNR1BGaGZUcmFHZmdjbU15MXpDeUtpd1dqV3FYWEgrVC91dzlM?=
 =?utf-8?B?Q1M0R212NUJONWk0dU9vKzR6aVJpSDlKbEovWEdIRDgvdGRkNG1MYlNUSUZV?=
 =?utf-8?B?RUwxbVVKaUE2OHlINkZHZXlFUUpKaW1lM1pObzBnTlpNNkU3SFJYZkU1M21o?=
 =?utf-8?B?RlUvOTBHSVZGUDhhQTViSm5aWjNTTHVDeEI2QzBQejA2eVpibjBBbjF1Y01z?=
 =?utf-8?B?T0lQdEFNQUdaS0w1b2IzOVVseVowTEovVVExQ0M1U0c1MmhveVVQcTB5Y3I2?=
 =?utf-8?B?QlNPeFFiRktndzFTdTg3NjVzSXBTNldxOXBvYVZpRlRjZzVLYTZxZjV4RXN2?=
 =?utf-8?B?clBsRVdvdnJBWGgreFVVRm5zbmxZVENVUFhLSHNsM0ZqTWdEeTlLeXpBYWw1?=
 =?utf-8?B?OHNNbXpERFBsNHViRHFtdEl6OVN0K0dlUnhtbkdncWxlUWs3NlM1MUNONlVJ?=
 =?utf-8?B?dm5hdnVGRURYKytndFAyOCtFUTJZK1dNVERlWkMyNE1weS9YbDVXaEZhd2tP?=
 =?utf-8?B?aWkwOUxTNXdxQllWa0hKY3VLR2FJcXhOeHJHeUdxVnI3a2xxdytkT0ltL0xS?=
 =?utf-8?B?MGp6T1k1N0ZLRlVxQlJ0VnlQbkNrUEppdmVzTm1IN0hFMWFVTUZEMFczSk5J?=
 =?utf-8?B?YlhyTU41R0RJdHdJcVptYzhheXI0WWkrVEVsNXdYc2I3N3RUd2dPWWlkUWhN?=
 =?utf-8?B?NUc1YlZJOGNNUkJ6bitVREJoMGZZdEwxT1pkVTJvVEo1bUxDOXdPNDR2SjFE?=
 =?utf-8?B?ZFdwWW91ZVFhdUFmMW80NFN4aSt2bkROaFhjNFdvVnJrTmNUNFBicXJLMHZO?=
 =?utf-8?B?c3dudnRENDlFOTZxYWFrV3NCTytpZnRQb0RtalFzV2VWNCt6TVNpK2pDclE4?=
 =?utf-8?B?U29id3dIYkJyV20vbW00djlzT1pGdDNJSmpwSjYyK01xRDBoMEU1OFNkQlkv?=
 =?utf-8?B?ZlNwaEJZSUR5M1VDczRmS2xTZERzeUxyTzliOVdYclJ0RGVzdXlGMm5NT2Rh?=
 =?utf-8?B?N25xbmpkM0ZrQVVwbEY2dFNOR3dldXFKbWxaL1Q5eFN2UDhSaGFtRDU5Z3Ey?=
 =?utf-8?B?MGE2QXRyV0pjRjRnZlRGY0Y5VmpiTkduUk5LS3JEK3Z0Q2tmZmI5bGZ0NFha?=
 =?utf-8?B?V01udUI4a1BzVXZzQUtGcDdmOUFUS21FQTZKVDJZWHpYYlRYeDU3WnhtMk5C?=
 =?utf-8?B?bFVFSTZxd21aNG43d2dpdGl5QkxQbEwzbForY011WksxQmJJcWQ0V25Cd3Rv?=
 =?utf-8?Q?nkx0XFOmVPCglesIApAGzGKlfuu5l+F4uJynI?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2171f07-a948-4667-1b19-08df470d7009
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 13:51:55.0985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6J+kqfTFrYP5wAt6Jr1eT+1+7B8SPPCflvckTPtcOFZyWZdEIwmDygYvbCFqopDwqTx+6pNSv2+f0ecSsjPeucXnv+X13VMFyaQvmwuytcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB165033

> Does jumping to out after the 1-second-period deadline task has run (such
> as on the 500ms exit-time KSFT_SKIP path or if cpu_online() fails) return
> before the task's 0-lag time expires?

Yes. In v9, the case will wait past the 0-lag time on its way out, once
the task has run.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
