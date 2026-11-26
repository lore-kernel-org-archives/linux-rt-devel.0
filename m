Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795700753;
	b=G1nYBAU1aNOyLXiC5Uo3Uon4Rsk1cPFkFrth/JcP2xvCFM0A/ydIwaPDwAJ1YJMlM2d8
	 7NFOROI8jdnmyFjE3xo1fpPSvW6WCiTvT30js6cu+jJ3Fd423CuS/HdWtoNFAbKYqJIet
	 2RJo7DKd1i+uSl+n+ohTfaNai+u+TtWJfHwf4akOyFVAFU3X6sg618SWJPEEwtdtrFJP9
	 KwNkz0RZeTU8rgW+dXige1YTNJmESWJfmSh2XyuoO6Mk9nUV+Q2L9eKUEkPt+3e6rVxZQ
	 WKGMYRoVME/kQ79qrQAxpnrljpryQPgCqI2c+fxZvBkHHgyUrGKJnVm9rBue7CDbBxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700753;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=B5dIXelU1Oz1YURJZjnYJenu1/bb80KJgC3lioQqs/Y=;
	b=5R0y3GoKIxMSfI3paDZtwbI9DlQ6KuGejMAKGbsu6I/195ouD9h+hEAcjgC59KXWYN5y
	 b4jtRH+Vijb4ej9Q0exQmJ20ZkfOOrEP2+siGhiAibLlzrLBza3cFCc1hjtkLBy8VFbrs
	 xM6f2Wpw+vFU+JLmnXLrjk39zm+L81JvHt70wgfMKAJfrjqrte7cpe0+6zBNGpEl0JaJ/
	 YVpgrc2RA9BhmFVoAUl4AJEbylDM9uHXNJumgk3vmrwr4zBKAM2W41xODp/4Fr4IvviCX
	 6mX9fACEOiPXaAxLPBvwaSwMaizDLjt2Xy+n6TA1s6EUJo31v9KIJp0n+saFircVltA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=windriver.com;
	spf=pass smtp.mailfrom=windriver.com;
	dkim=pass header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=mzRU2d9z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.166.238
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8BF606A321
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Nov 2026 13:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C8BF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.a=rsa-sha256 header.s=PPS06212021 header.b=mzRU2d9z
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBWPXh2717663;
	Thu, 26 Nov 2026 05:44:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=B5dIXelU1
	Oz1YURJZjnYJenu1/bb80KJgC3lioQqs/Y=; b=mzRU2d9zq0Bpd5CRv15XfBDbn
	+/xYpAsJVIcFDpYoRmba3xllgzYrMgEVW8BrFNa3Ps9YD7qYy+FhVoGAg/UjE2tD
	bQhipAmcqCAeGTcOrA30bP4J9eu0LwB+RZEISMd0BrO9LEW9px3KuwyNIWPNisQU
	QdA849zqgQ1HSYP/UZ4BRW0s67b6ItGNs0o4YTwJtlSg435wOFsuQHMZT5AZvvFI
	t1k0ormDz2ezF/F4U00d2fG1XEDe/4b9NmM5IdIeDXWCCsWui7wCGBqtUTTJWLBX
	Ho1/nE0xU1GN0CI1qcYO2vseOPzROsm7u9LKWbIe7/Egscf0Sol09lQZddK8g==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11023090.outbound.protection.outlook.com [40.107.201.90])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4j516wxa11-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 05:44:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GW6znNke5qxT3aeqgs9a8Q6aqdpDr3Ac8sYb7Ux/RFLUXbszA52YyyDed1Dq1UaL61nlr5ERr0ja4T/bmGu02OSQyaR+OPVGSbNCy0mHUjwUAYHsuYaAzy7PBx5cxEvb2tXOIawk4zWLMK5XmI0vyZr06xGvdT61en5DUAK/0RMdC//tkNdIWoXc2kV5uiSapPTl5Ny3W6/5+MYQ52IeuyHZJCRxbwhjwJy59hwmnqfFNswQ2RlSnQrNSyLu+jztwQ0xUYSqXf2SAmFlKcsXxjL/t/qMVVcZdCC+W4D+sE+qQPiFVkZvbF7WZ0DXSIeXBjKe5wudyncGEQ2NlJqPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5dIXelU1Oz1YURJZjnYJenu1/bb80KJgC3lioQqs/Y=;
 b=jMPzzvIt5yNOzjvKflV3g+9xbX4UhFLb2CIzTb6Jo6MO+Ema5V/80DRJla2x01z0XDPDaGn1z2Lc5wdfLuWBJq1Xah8knlFfijuMxwgY0St86UIygkqIZNxNZEYXmC+DLUXCVgUrCFVBoF9LX4tyKVBNOwG47RzbMvnBBsKW+QQqmSgIjBXOJ+zyzC2hUzmib5QsD1lgmCkWIA1l1JKRSoEUhv0ndNzRKEnqm7OiUo6LMB/ZkCnsg6yae6kZBoZbAzjSX7uq5A+Wj+mFYusi8oYTtfqZbWDQi+5zMtz+bm9PH055aGeSK8WyS+CC2Hw/25uQxF04zwZNtFn0asg1Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=windriver.com;
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SJ5PPFD25B21260.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::856) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 13:44:33 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 13:44:33 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Brendan Jackman <brendan.jackman@linux.dev>, Zi Yan <ziy@nvidia.com>,
        David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <liam@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Huang Ying <ying.huang@linux.alibaba.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, ionut_n2001@yahoo.com,
        sunlightlinux@gmail.com, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [RFC PATCH 0/1] mm: pcp->high is never decayed on isolated CPUs
Date: Thu, 26 Nov 2026 15:44:09 +0200
Message-ID: <20261126134410.17447-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0155.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::39) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SJ5PPFD25B21260:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d54b14-032f-4c87-72fd-08df4bc36736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|7416014|376014|366016|1800799024|261009223027099003|18002099003|260925021311599003|260925021911599003|260925022911599003|10067099003|5023799004|11063799006|261102123227099003|261022105027099003|261028144727099003|261026121527099003|261026140227099003|56012099006|261021123027099003|261021121427099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	f2ZmXFUTrHjTtQ15JgSZ3Q8ypaHVGpYoRY9N+YaBHjf+MSm2vBr4K9PslNloNPjLeZOVy2eoP06GQiUD7lXRFDFJHAdy/t7h6XYgIyDkSI8u95r07P2r3w1HgdTlBNleY4aDXCMRH/b/PN2JGQzEYbR8K5FPipEaU9xI2s+J9hkUZ6X9sRSn5eg5VF3tDR4FQDnJALga1pRz7iC65tiJlEsXZZbzPg53HEq2ePaMcGLESZfjQ83uRcCpW7xwub5a9s7uOPvoPUj5RmU1lCwbw3D58E98AYwR6sFECarfl6mM15WOPeBtURWcGobTNgP4VzSgKmA/JtsZd8p78QX0/7fAjvoqA+zrEaOzKnFIpsftHoYILYOIMWGiMqGyb2KMg8jbkbcZm9AXkRH1QWIAgkK/596Vxs30GjkRZam3ONz0kBkBRSXxgOJhNyygXzwZySp5lsGvnd5ofdl9QU4HZdHDdm9wKQqzdXdFXNCUhzW/mDLzayI6j5g3XuAIROB+vjb8xNy4cS8+c9cVUVigW5DSqCNmsq3IW0d2fza5O8o8A609vPcE37KLy/z51Z1GMl8+72LPUinAhmdft8EeLqACrU2bGAlYLgoxeo/7mWlxd8DSA4o4QuB4rPER84SxX/Vv5etCBC+5lYG0NVCIxbNT4T0NVGDDSs23chhBEUn6bby6H8jEATd5+CmSTRuaOS7WZBRbuC1GPBc2eCFgLgHSjNqn5Oi62eAknpxbZkk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(7416014)(376014)(366016)(1800799024)(261009223027099003)(18002099003)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(5023799004)(11063799006)(261102123227099003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(56012099006)(261021123027099003)(261021121427099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UFjbFPafv2FbBuW8RF3ipBpUAdr+1WArUZPldlG5fyDHC5MPhDZd6HsBJODf?=
 =?us-ascii?Q?22Kq5UlKtumG1cj0PpXbsU/jLQt/r68Ls6osymKX1KRbUC1a5UXnpTUxOZ8H?=
 =?us-ascii?Q?Ob2GgLsIkxdq5vdUL3XMZ8cefVX8LqbGN9eQDKsz1gOPWmVcTaVawhrij8ne?=
 =?us-ascii?Q?wPosS4sSQU6wf31XkOGCsnmIYdiLaZihE9tqAyvxp2Q32eM0kJpJxDtvGaq0?=
 =?us-ascii?Q?ButO1C5U0KJSP+o0w0UeMy4ms+TjgPAnRmCTR/X8JKYd+Fnknyp0gq7gVN4Q?=
 =?us-ascii?Q?EHmRTn4zLn5lrC3yRAmWsdRbQmmFpQCm99Yi/JhoOjxY1YEnX9O3XEaW3pzh?=
 =?us-ascii?Q?QfMfBj0RDanj4ZM1onLAd48lschhplkbdR7P6V9WNBBHhrUMUw4kzHg0az1d?=
 =?us-ascii?Q?xoqubi2ki7ixmFCwrOSCcXdxMn6kMXH31CjUfuWK6Zb7pcDi8cJX5/PDb7my?=
 =?us-ascii?Q?RzanE8uoto27XXc639IwX12s+W8stU2pNDj5JAkcdECN9h57xnmek8kI9so4?=
 =?us-ascii?Q?B2/F7kYQJVe3JMPuG6hl3jWjC3rRjhCkaOaNidcgAy3kBYRnI42H2hWkIBP7?=
 =?us-ascii?Q?/qbMxFCehxggDNeaIs6WkKToQwwzUlH65WJotrsp/WfY9VKK0VvPUEgSNCGv?=
 =?us-ascii?Q?aiPwxHC4QTfv6oxA6+sC4hlnUQnD+uSj6MmM7dzc5FPLCXT+VnSsFOfA6hdn?=
 =?us-ascii?Q?qhTwytXth+6TRqJxMWo5FfYJ1IYMjICD9paPT8VszgzeLRZFHBGXhQJ/Bjlm?=
 =?us-ascii?Q?pnBIxKeBGYlEfHpKwU3PFNdpiXW8Tp9mGySvfrKfL7mWkdQyHUIR99gQYL0E?=
 =?us-ascii?Q?jV5EVQNS8eLnhUONEjY186Kqj6nxWrSaggch+Cz0SCdghz3DfNtqX5SS/ZX6?=
 =?us-ascii?Q?QsYJ3ESHoMbbWQ+N6hsQFkMoa9SLUkEbHR2jZLsST1EyZR783DBt0bENx+6J?=
 =?us-ascii?Q?tpH5y8MLax54Bj/65tf38nQHpKAoMjVoJbgWQiwwcRyEqA6DY79PJCZpIY7V?=
 =?us-ascii?Q?0wrlYNNhKmyKodfZ2rEWlZPbDluGC9JBuU+nMvA2ieicJsxsaQnQakPRRQvs?=
 =?us-ascii?Q?NwUF9HUT+kCfy1gXxnh4RDrQDYbnMxFfGgfw3yFVQqLOZmmpZiq8YVuF12wA?=
 =?us-ascii?Q?sM2PJ5FFAADau8UAvKURFvcIq4Sna+04WFNPzDaiA9Aka1KZJZiTbZXDHb2x?=
 =?us-ascii?Q?/UCGyX0XKYTV8aCNACey/6QF+ayG81bs0xq1c7LdEdWLDpSGgCR0tn4OmHR2?=
 =?us-ascii?Q?JcmeEO/ySNA428gQ8myDXWSHJt90xoC6/CX97HHIlj4x+GWMRCfqS96KdJd9?=
 =?us-ascii?Q?S16aNutmJS84oDaEqTu9uTmCnr/rCCvW2PdA6gHAs5Cv7LuAVZfKwalBDW5E?=
 =?us-ascii?Q?XGGxQCOPgkGoMuw9dbvzTOH6Jh5IMhKrfw6GxdAOUqEcapfFVHMjs/P8+ZEj?=
 =?us-ascii?Q?0gzKEqDjWCdOvqOnCdt0ksUwFXhzSVxI9FDwuWW2weOW0LWqdePny4j582cD?=
 =?us-ascii?Q?3XlzpcaXqJ9UZJFfrv1DpUuiGi4I4fRd5BWTCgC0S1qk9P6FpDQIPWbsx478?=
 =?us-ascii?Q?/XhOYCr1ljNVdN4QO4syH670hqps9nardwSgtZpIB8CYSUw0h6JMkhs8v0/x?=
 =?us-ascii?Q?3oul83CpDhXdJ09xGnXN0s+3UG+zvzIEcRPkHln/k1jI0wZm0k9MV94PjC++?=
 =?us-ascii?Q?U5Jwz9NlPq1Ceps9T0tbhwH4qk5ap+21cwTLUDZA4CrlFaxCZW8ywgScRXHt?=
 =?us-ascii?Q?ARJJjylYJpJQ03YimU/4NoP03SFKfbY=3D?=
X-Exchange-RoutingPolicyChecked:
	UO9E52ofrXzMm4guLK3dzCiCW+FxaTOxAKWwSR8zA2Gob87mOBoKL23DYnJCx94QiyaCA8iWM/oGrfMMeqalUWWAztFfj2Se2BoUBeuu6Aiyar9a9AYFm5XKBhTTonuhvlPe6w7yLcxH938AjUPd9l5Bg0aUZzx/iTHVrjP9g7JKiLIGrwBma55dwTgWE6fuzpkHucJHdVbEmI/3hhXmli9neJQLe6EIOY0SA1OEdjiZhpqWCHGUj+Ek6b+iL9j3ed/fAbWt7WH7xrbCkPmB5O134u4nKLrnM3SVfhM8hLv1kFrDewRhmBQf1FxEy8LWhGSP7Uu75OFW+VWICEFYdg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d54b14-032f-4c87-72fd-08df4bc36736
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 13:44:33.3894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+RvPV7P+1CIr0zOn43v+hqSc6f8v/nLvILw/Lz4A+ZL8Ad/7/vis90xi3R8vBSuXSFt5emZcu4P/MBV6OSRxapGIGVfevo3wveAxzqT5FY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD25B21260
X-Proofpoint-ORIG-GUID: 3hOoegEjtdyuzfNEEU3fze2I_U33W6nB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1MyBTYWx0ZWRfX3jhDF6siAtZ0
 XsHd4QccPu2GT9Z6mwSAiJTNlITYzJWS2qJFR2l8HOIkwL5jFBjtdcNCbxZP0cu3iJlVzINS1W6
 +DUzLD2QfKbWrkiS8SrZU1pEIMbzN205phaM1WtNIY4r2Yw5MrN7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1MyBTYWx0ZWRfX23mSm3I3ESo8
 I96tymf7lv+uS9RMtgRfLzL5vTiOMM1ZknANIFSIOmGQR5OBpMxYxGGervoCR9ApWlrV4Oqbfxj
 Q4GAJYETy1PDqumTsTV5k1RRja4yaORD1IZegVXkJm+NLJhMAnBi+WP897Dr7lzFsCzAVzoqleU
 YJFiHAZF8v4ScAEKb7caL6kFKJwQ7GUxQchSz0R/CrbHkaTVd7/lskRxWbIcvqy+oePXQ+DKva9
 CpgES5QmX7blJAsUz4+QDbqcIFIPnu+Ab5rzhHQ3x6IiMU/083U6HNM74DI8Ob40BGkSYw10rKu
 0SyrHUrSAqHqrAbrPF1iFrKtdvlO19+Quo4+184/Af4kOycfgmfeuy3Rs/lS0HScPc4/qRcEFPX
 uMmyfylZKZme65Ak9WZwjIEEfn1QSMWLHAE+ikuAFfkM8LiPKtxepTSwBtmCdDWU+8L0xOcG/ZW
 BSBX8k3ySWMKq/VjyOg==
X-Authority-Analysis: v=2.4 cv=bofZl0ai c=1 sm=1 tr=0 ts=6b0837c5 cx=c_pps
 a=1es5Iy7n+cWvltLRflzOuA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=8Rs4xSTzrIzHdkBcCPQA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 3hOoegEjtdyuzfNEEU3fze2I_U33W6nB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260053

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi,

On isolated (nohz_full) CPUs, pcp->high can be raised by PCP
auto-tuning but is never lowered again, and the pages cached on those
pcp lists are never given back. They are neither counted as free
memory nor attributed in /proc/allocinfo, so on a long-running system
they show up as a growing amount of "unaccounted" kernel memory.

This comes from the combination of two changes:

  - be5e015d107d ("vmstat: skip periodic vmstat update for isolated
    CPUs"): vmstat_shepherd() no longer queues vmstat_update() on
    isolated CPUs, and quiet_vmstat() calls refresh_cpu_vm_stats(false),
    which skips the pageset work.

  - 51a755c56dc0 ("mm: tune PCP high automatically"): pcp->high can grow
    up to about managed/8 of the zone, spread over the node's CPUs, and
    the only thing that shrinks it is decay_pcp_high(), called from
    refresh_cpu_vm_stats(true).

We hit this on a single-node, 64-CPU Sapphire Rapids system (256 GB)
running a PREEMPT_RT kernel with nohz_full=1-31,33-63 and a
containerized telco workload. After 8 days of uptime about 28 GiB were
sitting on the pcp lists, mostly on isolated CPUs, with pcp->count close
to pcp->high_max on most of them:

  - Setting vm.percpu_pagelist_high_fraction to a non-zero value lowered
    pcp->high, but idle isolated CPUs still held 300-450 MiB each, well
    above the new high, because nothing on those CPUs trims the lists.

  - Only a remote drain_all_pages() gave the memory back: MemFree went
    from 126.5 to 154.5 GiB and MemAvailable from 157 to 185 GiB.

The patch lets vmstat_shepherd(), which runs on a housekeeping CPU, run
decay_pcp_high() remotely for isolated CPUs, under pcp->lock, the same
way drain_pages_zone() already accesses remote pagesets. The remote lock
is only taken when pcp->high is above high_min or pcp->count is above
pcp->high, so an isolated CPU whose pcp lists were never auto-tuned up
is not touched.

This is sent as RFC because I would like feedback on the approach:

  1. Is remote decay from vmstat_shepherd() acceptable for isolated
     CPUs? It is remote work on behalf of an isolated CPU, although
     bounded and only after auto-tuning raised pcp->high. Alternatives I
     considered:
       - decaying from quiet_vmstat() on the isolated CPU itself, when it
         stops the tick; on PREEMPT_RT zone->lock is a sleeping lock, so
         freeing pages from that context is not possible there;
       - not auto-tuning pcp->high on isolated CPUs at all, which would
         penalize isolated workloads that allocate and free heavily.

  2. decay_pcp_high() now also takes pcp->lock for the pcp->high update
     on the local vmstat_update() path, which was lockless before.

  3. The NUMA remote pageset expiry in refresh_cpu_vm_stats() has the
     same problem on isolated CPUs. It is not addressed here.

Testing: so far only built with PREEMPT_RT and NO_HZ_FULL (W=1,
checkpatch clean). The analysis above was done on the affected system
with a 6.18-rt based kernel, but the patch itself has not been run on
hardware yet. I am sending it now to get early feedback on the approach
and will follow up with test results.

Thanks,
Ionut

Ionut Nechita (1):
  mm/vmstat: decay pcp->high of isolated CPUs from vmstat_shepherd

 mm/page_alloc.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 mm/page_alloc.h |  1 +
 mm/vmstat.c     | 14 ++++++++++----
 3 files changed, 52 insertions(+), 6 deletions(-)


base-commit: 9437046953b2fb3bf55b36582450ea0267df82a7
-- 
2.55.0

