Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0A3064B5
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Jan 2026 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445881; cv=fail; b=pLMQFzTyE4I7NJ/ousiIt+V4FtXrHCO+R543LxmYKOS73r5yB81lYafcYZNniBeEc8pM+UXMHOH7pQLHHnPFBkABXobo73RixY1GymRCDVcNOpl3Iplr3X5Nt4+IF6rjfoCiCl7JM86z372VgiCs7StW0fCIMf96jtucnDNX8M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445881; c=relaxed/simple;
	bh=+uyFTSO4cdMp8mkDn0fLPGN/0ZmAWZWtLzESoqTv9+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vFSg2MfzDsroz3IZPiqo1WS9T+h1mqrzRO4REqzQc03e2snoZ+bscdP1ORyxkJnOUETWPM18bwHvg7kF3rxb3yZcFSbrb90Ck5gGAmPFTEhp4RN3lLiYY+leDrOzS+5UzX8BbysU7r+bArPhgrTt1u2rWkDT+DoHbW8/DPI1hqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e0KLhysL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C4iQ5e0l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e0KLhysL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C4iQ5e0l"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q4sMpF1030005;
	Mon, 26 Jan 2026 16:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4T28+rYzoD2GjU2Fl2
	WAghCmdjynwmgOEZO2WOxO5KY=; b=e0KLhysLyc5w/Ei+pnb1yT5wZguDJYVKcK
	qf7bRWzeiDyK1jJxKDGW5LAkVsqwmQMAiJcwns5UiZisd4VVZJxnm82PfenWo9am
	lzTisJ8z2CdnJu2m1HNu8TG+MlPQUIdYwjGSf4xTOMXCDV1H7f7b6j5ZUKNqvnCJ
	IsJtRX1s7hFiI5opPA9Je07mL7VbgN8ArurLkZ8X7P+FEYynSEVsOtUDowQDSzIS
	Cpj+EpIhkEnvXkFGqYmnp1KpB3fpBPHtWUqyvoCHbQcjAreaJeKOEkx9TJNa59Fj
	ZcIK8fkrCKZsf6GGgZ3ddy+3qTv6FARAjvjfg3PrAvwaBa/eTiqw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvnpsa6q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 16:44:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QFXQwQ033652;
	Mon, 26 Jan 2026 16:44:13 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh85rx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 16:44:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MP8YfWo/znqBh0GlfW+8z1NAbuyxiBzf3LY4OLFNUUpqNYHRNP89N8/w7uytbYKakEjlVRg8WjsoUeDfDQNvvnZW4tPYqjAGykWE8VNhuTB8eAyNdL+G/JY3KN9TSCtBRhAWQvaa1y1NNjs/+FQ5D/VgERcfJmaKTBnOFJycq2qawT2bNVF+OkMX/FgdDnqkh9WAq5BCMfoAMDGGANgNTxpOFApTKpa+dgzv6Gz2q3QWwqVVkmmz9K2B0A+EC1TYJfycFPnO5C4pEu0vIcxQut1DXT372EXx2eI8J0O+fHov/SH6SRJtE7yHasX+WXeGyg+kvMxq4aeRDY1ZB7GfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4T28+rYzoD2GjU2Fl2WAghCmdjynwmgOEZO2WOxO5KY=;
 b=mMs0tSyyXHg2DInea0r/KGMotzSpryAk6Ag7nelau7nHhNJIL2eFTCf7LdFVnFbW3xntqcDqvc+fFVv4Lqs1EckQi6VUmurIhoa9zTSZWp8bohI4BFPBPSWKshlTWtMoDjIRmFvOn25UrEURe5Z8ikiQjidiRD2Qj6rwYFl7LIa1Hb1/F1JcKlufipIh4HcWT0B9j+udeGo8A4T4Utvux2a34lf7XjJzmtVRlmzxXzPP/T7Fc6V6P2gVRwbqv0GQI9RHehHPkkgywTEv7I0nDhRpFuAG+5wl1jXYWUzIXTDVqYaAkGhejU4w/9UsXvvpW876ugKSHh6XSk3UbrNqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T28+rYzoD2GjU2Fl2WAghCmdjynwmgOEZO2WOxO5KY=;
 b=C4iQ5e0lBwKICGJB46dU6nrxPEfHoneg7Vt++Lt2xSQvFtbUfs8y73DibdnIz7AYx4si4QW+YNinYiU5mLgofqeuAoqLRGdnpm5w4VDXgNy+MZZK208YqhoOt/IqGKQq1g1xX3W2D4vHtjCboyHNPHXuvDEkrvrXtaQPZExtJGo=
Received: from CH3PR10MB8215.namprd10.prod.outlook.com (2603:10b6:610:1f5::7)
 by CH3PR10MB7575.namprd10.prod.outlook.com (2603:10b6:610:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 16:44:03 +0000
Received: from CH3PR10MB8215.namprd10.prod.outlook.com
 ([fe80::4ef1:fa49:5a08:c1d9]) by CH3PR10MB8215.namprd10.prod.outlook.com
 ([fe80::4ef1:fa49:5a08:c1d9%6]) with mapi id 15.20.9499.005; Mon, 26 Jan 2026
 16:44:08 +0000
Date: Mon, 26 Jan 2026 16:44:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 09/10] mm/vma: update vma_assert_locked() to use
 lockdep
Message-ID: <09ade6a7-0ff9-424e-a4aa-686896c9260f@lucifer.local>
References: <cover.1769198904.git.lorenzo.stoakes@oracle.com>
 <538762f079cc4fa76ff8bf30a8a9525a09961451.1769198904.git.lorenzo.stoakes@oracle.com>
 <6c4162c5-1703-45db-b9ca-96ecd8ce551f@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c4162c5-1703-45db-b9ca-96ecd8ce551f@suse.cz>
X-ClientProxiedBy: LO4P265CA0327.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::10) To CH3PR10MB8215.namprd10.prod.outlook.com
 (2603:10b6:610:1f5::7)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB8215:EE_|CH3PR10MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7e2afd-c3f8-4a4c-367d-08de5cfa2007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yXilrjA0d+dPGZeAfWK9jR33hi82v2boIBbef59wGRmlXZCxoFFayhrnFHby?=
 =?us-ascii?Q?oCdri0PRN3O4AkmVxr67KFr22Ffj4zvG4mKXBYGWqv2CXllpHlqGidx16hKy?=
 =?us-ascii?Q?tWIpJPj9BmErLzeWy6K+320E1/NRPS66kr6Wq8cdzIheAN+JcImYIsTryh+K?=
 =?us-ascii?Q?Mm9CUcrPrfIrrx+P2C32v0zsPCL8+q1eeeyzn9siREefITlgM48JPYnZUU3l?=
 =?us-ascii?Q?SStS/1SRXox3s0zFWvvaWiqrJyFWK7pRdA0UGzlfhPkLldbHCrQKjuwLUGaw?=
 =?us-ascii?Q?nHMnLHCeM+vZlYpHRvmJ/mwfVDfEr3SJ4pSCsekqlphZzy2tlKXu3j5WGS4P?=
 =?us-ascii?Q?UO7h03jsH3vYHUjA9dBG17ozNI5aLaG8UqQRdOlATTq9yq4LFKl4Qucr/oov?=
 =?us-ascii?Q?+Fnn0hFyBMKgP3V4L6FnIaQ1m7uF5bgz/7y/mFHAFVYcIu/dIYCTjBMdfcNP?=
 =?us-ascii?Q?3C0KYQ5ZBUPbCe8nuUNZ8KV7RADepy1NuNloelRvVqT6d3kIIHlz346JhaDV?=
 =?us-ascii?Q?rTRD5DS3D7koIrqKP/STGshdzaeN3rXQkwAS0RSswnIPS8B7HZQdc6BYQ0cM?=
 =?us-ascii?Q?TGeNbPPNQBklJSxppGbIAOaTEfqGcq3bonpOEV3MPDUYUIMrDTFpS6Kex7jK?=
 =?us-ascii?Q?3vGOwtPc5DQOKWraZXu2fFWls8ZOB+IdUtKxnpraxoldLSbidoNcto3lD0hJ?=
 =?us-ascii?Q?DQmhx82zj6WiVptPlBlztyVn0qt+kNidbgddTyErsbXPqDQpDiHYPaIkh2Q5?=
 =?us-ascii?Q?I63EVE3RzBMMFhGbujvnbvPS7cXhercExWbsEfSeMwkD5E157pUNzub5mbHH?=
 =?us-ascii?Q?w20Xl5oD1opL/GY1HT4j44vqiDpv69jAZE/w9kOKdNp6A0bjA5iymzj9VARs?=
 =?us-ascii?Q?m9Y6mu8lbIUO3j6HYRj1bbfRkadyV+Cxk/iRrmzlokJTQpM9pPm/uqcy6WLt?=
 =?us-ascii?Q?7IrAiFGkeZGA0dy8i4v/yappZgs0IgGnCnowNcPE4SgwkT9++C58KvCOJdC/?=
 =?us-ascii?Q?6FK2VVWvdlmMoe2oXfuboRYCjB+jY9Xml9ZJKDTIgkcKH1CK8ivWmBWsFAqW?=
 =?us-ascii?Q?czqEJzHEpjw/1JpiDaFN0zijOnylc8TiNZkbh0SkH6oU3O736IDGskjF0MRU?=
 =?us-ascii?Q?LkCJNfmensgEJu8+RLAXtb5s5CQ1V9KFz1XdQ5VidPcHjxFPpe6eAoRhs1+r?=
 =?us-ascii?Q?/jw9mjyZ3TlsehCyLCLyatgvPBTmzbIyoanKwDsucLETN9e3Cw+xrJgmpNCE?=
 =?us-ascii?Q?8r+HtHqg1ovCiST/KwEI+cYoXFDXy75FMkBjRnJ/iuh3uz3CTsqS8Jn8Gz6q?=
 =?us-ascii?Q?Muuw/sw04d4d1yXUNGJG4e8w+qKKwZNrgyHq+37HlK1hoIg6IzMqVPMjyFu8?=
 =?us-ascii?Q?7poqA3UGEn9kz/EONURegFsZr/97tBNGhB5Ni7dvyYR6cgRfN/bE264BnSHh?=
 =?us-ascii?Q?bgWFNenS0WdXm+GFF7add119iyf3V5sjgnTBHptokWAx0i4mSO7ImwxteGue?=
 =?us-ascii?Q?YShd1/3mu2EwiWuDn0ln5HgAgnsGMRpJwcteHhZVDiwYSRUuBvX2W+eydwL2?=
 =?us-ascii?Q?e2CuoJfEVHDSaFiqHuc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB8215.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JpYQjiUnukHcfOP3Xz5L1j7vQ34s1xQ1O+m0di0AePvnk8SWZO5Z2gsXT3rH?=
 =?us-ascii?Q?bqKEBg0sGXfLQTKlsl3AfVPJJbwg/LqNQtWWXPS/HBYtgCisMrG8wd/g0SZJ?=
 =?us-ascii?Q?5T2mQ2nNG7XPMLQCgTHNkTXcIdxWsnLw9zks6kaqgXThTIx34kTu538wbS9I?=
 =?us-ascii?Q?MPBU64xyQn3Neid6P3yDWMz4ixL/HDZrQ/IMuAjfqQxGfVbTM53frlXu+CGd?=
 =?us-ascii?Q?6k25jy35qeBcJ9z4JJnsn6ivOgVswVZnXfhzinuwe/NhJF5oK1wYuf8bI7+R?=
 =?us-ascii?Q?fnuZqifAbGQG6N6ilfgjqIxdVaIivIWimRWEQfanRk7Vjr0PvIqrP3l5CHha?=
 =?us-ascii?Q?v4c6Mryxl30kZpmFY/GEka156h/9MXClgZf+vJiPMeQEm4n52OgNTwbFpAZm?=
 =?us-ascii?Q?A4ssARLxQaLQK5t9EKaCyvsj3Ggi2v9c1Gz4T06fSi0P/3m1DqcKiEP2vqVq?=
 =?us-ascii?Q?V2o7dCr3yO046MhuUTVU5+wnfNTrvGmJ+xdESforIJZLMROy+chaHJA/b78d?=
 =?us-ascii?Q?/EYmDt2k2ef59lm5DtQgAHztXMQYp2M/e/T7SYiBUz8qDsfmCKchqRxA56Ce?=
 =?us-ascii?Q?Vd31ZvzPFgL5Qp/7lzQdoYNpthcpCwOksRZlTezLZ9iAppta0yBpNk8JZjHW?=
 =?us-ascii?Q?6bItqVzbzpvQh/Z3ku/rXvLEPha87NYWUVrqLc4v9Sua983UtYVDDE5+aieL?=
 =?us-ascii?Q?2V+K3A3A5BV6vjiPoGzNnqCU2ir2eHE0APtAOXrvmyab3A2oAOi9nplN4dAo?=
 =?us-ascii?Q?XuuiPZUfYTuTtZYESOoG7s0a4kCSgpjyo6u0U6qfKD9lsQnRQ0stXi54Ex/g?=
 =?us-ascii?Q?IwOi5PsGz9pQI7AqCeIgooksfnx5zYNHpiiyfGQnS9cmsKFte9svuvLblzBs?=
 =?us-ascii?Q?wFMNvqU0F1A+8NQ/xV9+cehLKo4xTOqXEQnx1m50rLBZfZw8D42W3DlQiNCr?=
 =?us-ascii?Q?igYBo7sbJv8Gy4BArXu/XIta5PmHS/Jq27DrRYIhaj27YSnpo8FbGwfgdf6h?=
 =?us-ascii?Q?tDWeKe+w3xfw6J2EKsY1kx2YCaxwAwnYWy5Oo/F9B2o5EJV2tnLDSFVOyqCe?=
 =?us-ascii?Q?XPNU60EgVOEQdEuaRUm81y5EXsJbrXWlZ84753lExKuDw7OOzvVONQycl1wv?=
 =?us-ascii?Q?j9Ae6SyEbLcFHyNmZENjtYVf8i09W9zb4hNs9u3obyMe03CVvdecQgWSEOGN?=
 =?us-ascii?Q?sD7wWtJcuZSEyVtNraYSCyW2GpmX49KDcbH3zTRfkuvhZhcFlZnfcYt/pnIR?=
 =?us-ascii?Q?gkpdjoZwjfV+hLffmd9OyskQAxYg7+IZ1AgwUv98tl02Oc95lgLmzjMzWe6Y?=
 =?us-ascii?Q?GLmYuIezNp2wTd06ORiEX1SSP9aLL1SdgNOy+YcowK97O89JDX7GQ5SgbB1L?=
 =?us-ascii?Q?MmmbdmRf95Go8ggqoXwUO5wQXUEI0g20/YXPR/JXR2jsGUSVr8MRflvWBsJG?=
 =?us-ascii?Q?fo8UdDIQe3s03/4gGg86PLbLh5CNY8xqcGDJmH6UsdryCrASM9lscF5wEz8D?=
 =?us-ascii?Q?TxwdpQoccXIY5Zt/SeKC1yFwy/ZdRrMwXq/DzRwAyOjr0C3eTF6VDccS+PAh?=
 =?us-ascii?Q?iNKmtCsSFo1ocOro4V+IIAJCcKQBE0mecbZN1YDstOZFZ7MbFzzsqtfcHSKj?=
 =?us-ascii?Q?RC1SNdE+EOh30rnLvZyJFk4DHukipW7bDdHL8W87EfybjXha8+p1b+RLoRgj?=
 =?us-ascii?Q?ukJys/BzrI2+DuWClc/R/BhllILdvVnbWaoi95t0n2HeFQxe443eq5PAWWrc?=
 =?us-ascii?Q?dVWfgr0lx/LmIt3DSMJ45dW+lXxBASI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KFxgDqfOSjAVnFN8TV3w0rBtnZsOmcP3fFOuCcuybZq8wWxv27EbUB/3Z9Cdiw9Xir/kNcvvKqLinVnwDrh/DezFYgyK/N6tX55s4ZPDohb4wG/iaAlABZ2vIZDpKXiOfG5JFVvvhPZRonB84QX97Ep6vL/j63WKyuB2bsiEhqaZpZa6yshl9o0tHS5hUR0RUQSq9bZA1LULOwF9n0ZnRJB8lxLOi0vvuqAlggAa1e9/OeUDMcSGjZ50Pj5sBCticHT+5dY7p9+3Fn8/xReDSFccAVBEEdCl2sjrDoQ//aFtUDvqaeb8ujfpro9XKwI79XjLsKOz3KhfUC/KCVVvZ4v5NIPWoB/YLu98UAQ9d9/tjMAgsrU6Nvcvlnq/lpqyr45WCX1QJi82cwuNQrNCf4Kkw/jNEkcPsDcAs/ahq8CB++/7AftSDGqVUM5LMTtZSogJzjv27lQ0DXn0deVICdCh5ZrUPKH4KudUayr4pcQU4rAnrCR55U9y759rlusF4c9cLWUi081g6gxFP/vYdu01MWAwx2DmdFhYvtSD/PXQNvzMj4oGj98PgdF1lRlbqLs1JtUkF8KReWP5VPkVlGtAjX44a9lk1d25dmUCDTY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7e2afd-c3f8-4a4c-367d-08de5cfa2007
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB8215.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 16:44:08.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mJe9u12G8iMmNzXbdqrtdULQau7AaU0aYKLgj6EJ+bRTvBTt3yuJuMebuMqCncuHkdV00uZ/P95DQWCmX78PnLNp2u3tAG6bN8Ey10P2mM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601260143
X-Authority-Analysis: v=2.4 cv=dY2NHHXe c=1 sm=1 tr=0 ts=697799de b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=01Q329iAmX5FFDA0JicA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: mbrCdyqV0ErKcrOpayNGDwJHkC5n8SVY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE0MiBTYWx0ZWRfX1UM2lMrRcRzy
 YsUFQ2VHG0r81zakqbu2Bfr9akc8SyR3uZNSNeiidkDUPslPgquOOA1PQf/6elXE7prkoSTdghk
 pcSCDda+q4RtRtYeVotsVHDjE4eZMelCo17jT0+hAiD0J4tVPhmV7Sl00kIg1o1hUHeFIZctaLH
 zly7chEmqIOGHW1Cf6VckrgnFhAWtBazKlXjwGeCWnPgVv/Y6PvC/HWKvzanSOjkkRPeUmPfCxS
 aeuzJI4ItGh4uj1kphWQb1JSBIKRWFfCKnAhtzWVp7DW+OFTq6oReQFE3xaYcozT7GwYcnv7hrc
 rOR6jgIyW62caET7Z8IJzwBoY35S+raltwMONNKm/TvqDiBPR80p63tAC4vNEnsdgdN9Ka7ASDF
 lH2ocSGZDh3MF1Z2GSS9B849xyXc4iH0oitT1anwbMZ2s0eKCHBKsSvL3byvcu1eVLKWiIsPIhQ
 LpOWkKSZyTkcC9ARkKA==
X-Proofpoint-ORIG-GUID: mbrCdyqV0ErKcrOpayNGDwJHkC5n8SVY

On Mon, Jan 26, 2026 at 02:42:00PM +0100, Vlastimil Babka wrote:
> On 1/23/26 21:12, Lorenzo Stoakes wrote:
> > We can use lockdep to avoid unnecessary work here, otherwise update the
> > code to logically evaluate all pertinent cases and share code with
> > vma_assert_write_locked().
> >
> > Make it clear here that we treat the VMA being detached at this point as a
> > bug, this was only implicit before.
> >
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

>
> Nit:
>
> > ---
> >  include/linux/mmap_lock.h | 41 +++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > index 23bde4bd5a85..4a0aafc66c5d 100644
> > --- a/include/linux/mmap_lock.h
> > +++ b/include/linux/mmap_lock.h
> > @@ -322,19 +322,56 @@ int vma_start_write_killable(struct vm_area_struct *vma)
> >  	return __vma_start_write(vma, __vma_raw_mm_seqnum(vma), TASK_KILLABLE);
> >  }
> >
> > +/**
> > + * vma_assert_write_locked() - assert that @vma holds a VMA write lock.
> > + * @vma: The VMA to assert.
> > + */
> >  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> >  {
> >  	VM_WARN_ON_ONCE_VMA(!__is_vma_write_locked(vma), vma);
> >  }
> >
> > +/**
> > + * vma_assert_locked() - assert that @vma holds either a VMA read or a VMA write
> > + * lock and is not detached.
> > + * @vma: The VMA to assert.
> > + */
> >  static inline void vma_assert_locked(struct vm_area_struct *vma)
> >  {
> > +	unsigned int refcnt;
> > +
> > +	/*
> > +	 * If read-locked or currently excluding readers, then the VMA is
> > +	 * locked.
> > +	 */
> > +#ifdef CONFIG_LOCKDEP
> > +	if (lock_is_held(&vma->vmlock_dep_map))
> > +		return;
>
> Wouldn't this work a tiny bit better?
>
> 	if (!lock_is_held(&vma->vmlock_dep_map))
> 		vma_assert_write_locked(vma);
> 	return;

Hm yeah could do, I guess we don't need to mix the 'uncertain' stuff below with
the lockdep-certainty, at this point we _know_ there is no read lock/readers
being excluded exclusive lock so it can only be a write lock.

Will test locally to make sure sane then send a fix-patch. :)

>
> > +#endif
> > +
> >  	/*
> >  	 * See the comment describing the vm_area_struct->vm_refcnt field for
> >  	 * details of possible refcnt values.
> >  	 */
> > -	VM_WARN_ON_ONCE_VMA(refcount_read(&vma->vm_refcnt) <= 1 &&
> > -			    !__is_vma_write_locked(vma), vma);
> > +	refcnt = refcount_read(&vma->vm_refcnt);
> > +
> > +	/*
> > +	 * In this case we're either read-locked, write-locked with temporary
> > +	 * readers, or in the midst of excluding readers, all of which means
> > +	 * we're locked.
> > +	 */
> > +	if (refcnt > 1)
> > +		return;
> > +
> > +	/* It is a bug for the VMA to be detached here. */
> > +	VM_WARN_ON_ONCE_VMA(!refcnt, vma);
> > +
> > +	/*
> > +	 * OK, the VMA has a reference count of 1 which means it is either
> > +	 * unlocked and attached or write-locked, so assert that it is
> > +	 * write-locked.
> > +	 */
> > +	vma_assert_write_locked(vma);
> >  }
> >
> >  static inline bool vma_is_attached(struct vm_area_struct *vma)
>

Cheers, Lorenzo
