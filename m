Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44410370D79
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Aug 2026 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308749; cv=fail; b=o45kEOwD7RSe7ymMVl6p+g1IIeHuCFPZm0Zg+VBvsA6tJdy4Gi7alYuf4v8TpxYq53yQdlEbiutwcTxZ0HpdW8QAtTyukcPJwst+N+dK7SS9X+rjN3GpAINiKPkqnKx+EGPEnSwJg37YQCNWVzHuNpjjIFTpmKogigCseAoGZMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308749; c=relaxed/simple;
	bh=2dbksflVigmyElmX8Ipho6FA5Plcd84tOBNE2drQusc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qrrju7njyCkRb7a/W+3GaSHNKWRBmPOqCBOX7KcJiPRv8Cph01sukvQL91vx5JJFb5e7S78MUqwxaXwyy77Td16iJmZ9JR26lipirHvTBnIq7OEXiom6SOtUnxYkGUM4waQINRCX2rWKdCSz/Lztfw+aTVAOA7e7jb/P/sBjYxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aHwRE5Do; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aHwRE5Do"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyEzYgAPPmOvfVpYwwZGvHwHi1KUV6fhdoWQFGNZE9wBnXjU4MsLQQd0t4sTxns74gs44Bu8W+Yz4FYn7w0yM336U6mj+fAzkffefB8jd/GlrOjbGR2FNUOxN/ID6TA1cX1DHL+7+jDgpDfqrh9jQaZdpvpgs8tUNottLlPUQyhx2iCUxSHfBKWmImesznXe47fpRUXUnCuimb64CrRvpoG9P12bClgTxXp1yPQ+TLRwJy8HlXhohfNskkIoMUtE9kLEZbugExsU9QG9sqtVD9vzX8qy0igaxJjxG9qwfd3gbpyMuJlicMg7Vvm++KQpAzmx1OAh+i/UdNbfeGREvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A88rY34TRa1GHq/uFMFMRG0HmaWJHAK/pfR1RtSuN3w=;
 b=cr3qY1XDoxCgSWhaMHml5z6PcqyB19WdSB5GNypWxfixbWvck4tb45BBj0JPnhEDsL21qn0wo+vX/nsP453/Em54tdLh0M2lPzpEuFX5mcx//2XZkrDc5HbJIOZVfHv1fd0RYH9mz6Otbgzw/itsMOMOFsipRZdP1LYCv/7Y/p0a5R9qWJ/OrKL//CqNRoKYlQKdNzp77N+il6vhTOem659S2HL69hXO+gTIXscLEby/x54qfyUWjC1NM6Ttk9LlCKrqwAjY5ePQjFrVADnE+vQOpKAaBVmWcugnRHyvKdrizO8gYb4xGuiScXRRx6ZPLjqhz5e+ewV1kfUrG7WltQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A88rY34TRa1GHq/uFMFMRG0HmaWJHAK/pfR1RtSuN3w=;
 b=aHwRE5DogJJzlPQe6WAVJUOH3TLv7bT1kjsu2Vr18F1ingYUlGHcZT8ZBR2rqRynN+mYKkLvEeOsegmDXe4/o+4cIgmhtCGGtzfy8Zn8q/BX2mmAXEKNK9nkFe/UUaKKjco7ne6Rp1lrHH1xlIkkgOGhMDiWjAhX+hgCQC7ejOIyhRtabOz/ACZ4zXUkn2/KUmoql96A+KjxjQhnqr5WmwsdsGcunvOOI32vpl6xrVTLI61OoVdpL2zruNFOtY0uatBc8K23xO0rywf/T/vBzfaaPNsa2cpB/yNTkXET2os25TtSg9xtXnJrA3gRnZ3KG0XdNSYHGZQGgz7IpDm2HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6508.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:566::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 10:38:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 10:38:54 +0000
Message-ID: <11c2d3c4-ea05-46a2-8579-c5aba1bfa204@siemens.com>
Date: Fri, 21 Aug 2026 12:38:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] genirq: Honor existing IRQ affinities when
 setting affinity hints
To: Jakub Kicinski <kuba@kernel.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@kernel.org>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
 <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-2-3f79a99cadaf@siemens.com>
 <20260820094153.420202f6@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <20260820094153.420202f6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6508:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e16438-4b47-49e5-8b05-08deff706612
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|10067099003|11063799006|4143699003|56012099006|3023799007|6133799003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qgvcvu8VRWRAxhF6zuy8aAKR429+9ob+pSwrtpcbjDkqsLwCeWfazKI+igpFwvk+vKu9Z+8TViEWcoqhT8X9+f2WwxTrBmztuEpKYn4Tw3mMRlPA/TWnz7dbhSnXAGJPvf4FYOt4OhzyyKMTgL6b4Kta3CJDUh5QD1W2+gV+NB0+86WFHoHwjwZdvhOxRiNRmzu2cESzSDY/D2lmJ66hPfmn+vAuABWEuGxTmd3aTaXH8c/c4tqogX0LNqHLaECdpsOXCZsLrABKLkXdm1Hts3pQx4QoM31hREQv/CV6fXaTkwRg1NzjZpHK7Rougm16yrhQnE0U9n1uTVjrLQvlev5Kp48gXryhmFsE5RS4mrE+mCZu+7Q3sZKjGQKnGTWKr+hOPOarX//kDLiWKS1vMRpSs/ANVUk9uirzH17f1qm5RIkz19ZU12XBSj9oxc6rjzJV2O5CwGmXeHiww1y4MpnEluUNG9Mq0VPLwOHMLYZcrW7OGnvmRKom0I+0+/3K//2Y8F7wbl1oqnlbXpKrG07KizI26Ua9qR4mwryZui6jabIkBBQURfX+YqWn+pUWYPRFJe7TDgf4GW3TRuTZbNJNwJqfUeGmVCn0b9DedulM9zwUwkUXaxec4nWAeUGXxgRO1wrP6JHGP5RT3oOYFgvKGkXwmVOHnnfxNfe/aVI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(3023799007)(6133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUpKR0Y1MnFRQldodjNPUXBtekxIVTJzdHFSN0d3RmpxNWllekhDbElNMGMx?=
 =?utf-8?B?OFo4amRUQnJxS1ZPWTcza29tVm02N1pndEZoSUpTdDZKcVQ4TU1QaDlhMUM4?=
 =?utf-8?B?NzA1R3hZb3FOVlJET0l3NUNmM2xFa0Q3Rkd1L1EzZTJqaGVZMkpyWkhJbFph?=
 =?utf-8?B?cWZqbUdUOEN1WlRlYlFEU0xEQ2lZZmhJM0kxemZhU0RUODBaMUxNZGpaR2g4?=
 =?utf-8?B?MFlKdWZhOTN2SDBUYmFnRlgyeHhOU0hWT05VQ1N1dTI0SGN4bFVxTTQxSXJT?=
 =?utf-8?B?b0ZUZWgwQUQ2RytJbERBaHZJT3MyeUFGaUJGTitwblY4eXEwMG1Kd2VGellq?=
 =?utf-8?B?UU00eTBiVHMvZDBRaFJRYW81MTJIdlN3K3grdW00T0tlTFNOZjJLSGFUK25P?=
 =?utf-8?B?Z2VKVFcvb2FTaFplMVRzc0N2NE1RbWkwSXljdjVRVXNnY09SSEozaHRDcGx4?=
 =?utf-8?B?MHpvUXFtL0lXaU9YaXE4aEpqMHRCakhIc0QwcWNkVWt1T2J4WDZJY1ZRWUdS?=
 =?utf-8?B?N3VYSkZrbk9TRkpCc3NzUjdvalVEZnI4OFVNMVQySUswQ2tzZHlsYnUxaHpC?=
 =?utf-8?B?dnppLzd2V1lhdmozTURNVnBhMHdWd2hSTzR6MWxvazJuU2duU29RU3VmTWs0?=
 =?utf-8?B?ejBaQ0N0MGg5YnpWNjVVZ3BkV1pNTkYray8yemtWTWZuUVFYWEtuMmFMSUZ6?=
 =?utf-8?B?ZFJrQ0Q2RzZwZnY5YnZMYjE4WkFhaDVGWndKMDFzZGlYYlhrQnZpbUFuWTBw?=
 =?utf-8?B?TUhzeHh2VjdGaFI0Rk9QcmNOQytJaW5VVVI3UjV4OHpOa256dXpNakpyVGt6?=
 =?utf-8?B?UFkwY0Yrc05YTEhFc3ZxTHlMdmE4RzcvekVTaHJEeW1tT3A2VksxUFM3YUl3?=
 =?utf-8?B?TnNxYU5Ma1JjWWpuZFg0ZDQwRmY3a040KzNmN3VlSHUrUlBPUE5zdzd0WW9W?=
 =?utf-8?B?Q0JjMi9TdUZaL1hKanJIY05sZ2dWbTNseFA1ZFVvTzVpVXIyK01US1BWSlYy?=
 =?utf-8?B?TEJBbUxVY0MzVkVTY29QZ2xNUGh5K09qRThpcTFuT3dzZUVOQUVOdmxDL1pi?=
 =?utf-8?B?dWlwbkp2cStGdHhGekdiRWMvZ0Y4TnRjNVhmeVlEQTNtdmZRaG90UjVlSjJZ?=
 =?utf-8?B?ZmkySnhEbzRRdEtrTjBBUHFWcC9iSUZTcURCVmRHZmQ0Qi9zQmFUaTR6Wkwv?=
 =?utf-8?B?eXB6L1ZNUlRnNnRFQ21OWHdoQTJtamxES1ovOEVKbU1mbGV2L0pDZU5PRlIv?=
 =?utf-8?B?S3NBcUlwak53V2d0Sm9FNzBEY1QzRkEzdUtEZDBEd3pTdkpseHg4TzRRU0lu?=
 =?utf-8?B?VUkrZXY1V0lzS3ZnVnVRb0E3R1ppWk15UzJPNUZKQUxSSHlaeityYWp3TFNY?=
 =?utf-8?B?R0I4Zlc4bWk1UUc5RTN4RHdLNEpyM3lnNmZvY3puaDEzOHhqTVN3R1JSOFg0?=
 =?utf-8?B?N1pPR1RkZk1vb3RudUx2Y2FOS3ltbi9MY3dVYTZYMFVESnZKMk05bjkwYmts?=
 =?utf-8?B?dHFtL2hiMG1FQjJ2REQybE9LakYwcUdSZVJNcVUvMVpBbnpkS2l4RlFINUEz?=
 =?utf-8?B?SC9EMHQ2WEQ1OWdHamtzV1U2UCtzQ3N4c29XazN1a2g4R2VDUnMxakpzWXRw?=
 =?utf-8?B?K0NycitDM29ybmFLY2R2dWhobkk1WDhZbnROUG5KcXdMV2tKY1JVQ2VKeGhw?=
 =?utf-8?B?b3h2alZvdi9ZdnE4UjRNMWIzUnJoRGRhN2hnMllnZWh0STZFL0l4cjR2Sk8w?=
 =?utf-8?B?TTllWTFBeWJPaGRkb1k1M0hBSEVNNTdKQkQrTnh3UG5pZ05pdzVDWVRINWJ5?=
 =?utf-8?B?QmpCaWFVVFVqYWRKZFkzWHBxSmNRSy94cE1QeVNlTEZxTHZmeGVqOS95WkN0?=
 =?utf-8?B?M05nNGpid2xkelcxL2dtV3FGSnNuZGI1d1hNM1RLRklxdm9ndHBzZ3BoeG1W?=
 =?utf-8?B?TnBrd29XTXJIM2Nzb0tFQnE2ZHFXeXdNREkvdkRxeDlrSFVheDRMSU9QK1Nq?=
 =?utf-8?B?bHNlZnJCZHEvSjA2MDJXbkN1UmVmVDZTM0p0SmtiZE9FOFM3Ky9ZeWY2MXFz?=
 =?utf-8?B?cHMzNHVjZENLZFlHVVpMdWNXamhoTFR3K2hvOU13UnkxYVl0UkQydS9FSzFC?=
 =?utf-8?B?SXNqY2xIYVJxb0Vra1pnYkNlTUo1MW9vTFFZb1FuZGF4UGlpQnRENllsZjRW?=
 =?utf-8?B?cyttdDF2OVFrckdZa0kzVDN1UTZvaDlkc1pZK2tGZVlLREl0c0hST0xpVWFB?=
 =?utf-8?B?YURmNGNQMjdQUDFJSjZHWWFFdGxmSFJ4UXpTZUptTVp2OGRSZno3M0YvbjVv?=
 =?utf-8?B?c2dPZVZPZnlTTkN0MXdqNE5EajZseHo2VGFyeW5LYXg3WFlRWEFBUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e16438-4b47-49e5-8b05-08deff706612
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 10:38:54.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yRTh4ft3WVFtNg5XUPWIgcGEl3r6LkSaE3AUZ/iTM86NxvSvOL0fAOVFKZnH5fYN+v06oqg2HUTuMAtg00QpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6508

On 20.08.26 18:41, Jakub Kicinski wrote:
> On Wed, 19 Aug 2026 16:30:31 +0200 Florian Bezdeka wrote:
>> Some device drivers implement an IRQ balancing / spreading mechanism
>> based on cpumask_local_spread() and irq_set_affinity_hint() (deprecated)
>> or irq_set_affinity_and_hint().
> 
> Not an expert on IRQs, but this may make the API even more confusing.
> irq_set_affinity_and_hint() not setting the affinity seems odd.
> 
> I'd go the other way and either have irq_update_affinity_hint() apply
> the affinity if it's safe to do so, or create a new function for
> "defaults".
> 
> Really, the drivers are dumb here, they are just trying to pass to 
> the core a hint which is: This is Nth of X IRQs, please spread them on
> the NUMA node where the device is attached. Ideally this (Nth of X)
> should even be part of request_irq() args. IRQ core already knows the
> device/NUMA node. Drivers juggling multiple flavors of uAPI-shaped API
> is... not very scalable. People rarely get this right.

Fully agree: drivers should not set affinities. They should just express
desires or additional constraints. The ultimately resulting affinity for
an IRQ should be the result of the various constraints that kernel and
userland may express via NUMA placements, isolcpus, some dynamic
isolation/grouping constraints, or you-name-it.

I think we need a big picture how things should eventually look like and
then develop a strategy how to step-wise convert existing code.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
