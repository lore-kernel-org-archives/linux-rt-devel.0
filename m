Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23B81EEA5F
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194291; cv=fail; b=mGgFRI8ZvuFy1L0CQbQDPVhmEDGD5MVNirMWA15MNW/fE7CWSkxyidJL+qHVDA/uSoYkkbmfBIpQV5aEZqnEpSFHajCX4yHpTKl8yjx5Hl0TLKPj00+Ro4azfv04Dc8t0H9VuPgSi3ZfJE0ibldlcSpjAzrFoGcd1TnzXkXViRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194291; c=relaxed/simple;
	bh=4uGvHxVeTPd41R6iRtbf4QcSHmSH2YpVNcpPqHS5s4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C1URJvARkv0LLLQyTwuUvlavuK8Zgti5SiyiFTP76jR6wlH97bZojxektE9F8JHpEDJRh6T1nO9xMVdCa2Gt6oO+vyuQ9ASDRdmZH6wipKoqlrzdinmhx3JeRqjSxeTuxcvsGCF93oHhYyNfNHAmK8F4/bvzv1R8YIMNJvbY470=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EFTVAAtt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wMqh91CN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EFTVAAtt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wMqh91CN"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60ND6Qdm2973522;
	Fri, 23 Jan 2026 18:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4uGvHxVeTPd41R6iRt
	bf4QcSHmSH2YpVNcpPqHS5s4w=; b=EFTVAAtttNrgPybzpUz+65BxNR7a/6qL79
	B8Fl/+jBq6YRnznIwWq3VG91m/8wR/IQxWp2wUOEIUHhX4XkSwDA3jdBoPMZ7ngc
	el2aGOf6UCZYBuLWdyKwekfXY3rkwRM3H86t7wR7bl0Kgdo5aASY0LJcm6lVtyXn
	UqX8ndGF10/qFq2pEAHiQ5LIiHpmlOf47vMx73fdWWu3H/YszfBGnfQESAX70CNe
	SaxPXlNRNXIb2Enu4mL58vo37xUVAKX085ktaRxarytacgdqossqW3FFn+FCyJ/j
	+qPbnqbJNlNb0nJpn7LhcyuZ3CH+811poUtZ3X1gVGsCD1Wuo9nQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagcyh8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 18:51:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NIIQ2f038178;
	Fri, 23 Jan 2026 18:51:12 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4buswcdegb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 18:51:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxSK10bZRAbtrDxyxUzOL8yMbfFrbVrNcB29DrMe+nqOt9Op/M0WqiMa/17qgxwn60s1bGGf3GDmNCOGgxZhV/5Z7XA8kFI03UFeQtQOBPv3aE77QmrtYmPw1J/4rUw3U6TAsq12O0RnatyMaxL4XCwynX6HxD0DQ0YMiwNoqqz07s9llRo8NSsGYonuL45Pj1VmZKZc6Gx2a+qXRH8NtkhQqjy8MMOWbioOZtS6eRaWjvgRwZOESUxsunpJndjXkSFNtjfZYhJkntXJEnlUQVArmIdS8klLOI/jQMyqEzpGfGtasNC8Um6w6TXoRyco8mAJRwEcj66CJBnOoR7UuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uGvHxVeTPd41R6iRtbf4QcSHmSH2YpVNcpPqHS5s4w=;
 b=FcvWjh8aAR/xQfNU2s12T7EKf5HYXNqFuWae1/fyxwj3ONxDAUjACH3MiGa7tCiESygq2pIT66FJlx3IW3ItAeWypww6tnsRmtBgkHb6OAcSCSKgLYTM11GduIYVhsZkrqDSiuAD6SILhYd2mrewh70eAVB7ADka13dDarQn2Ky4PsNSCJr9T34vHPIcJdBAkcWoHNWbBOykSkUFQTaaAO8eGyyUUWmf/9ByUvhIzQSQWHGUFOSChGt0lag4Hqyz/PtSufC9fdGZn8bRiqeVrJoJF7y17OdDmjym2iqXb+QMZLXrhnlOGxSfPPQ94XKDMm4dHP+cWBS5ZQWDlIQzJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uGvHxVeTPd41R6iRtbf4QcSHmSH2YpVNcpPqHS5s4w=;
 b=wMqh91CNaNDkSuN8vgMnGU7f3k+R45jUh9t0jXtZRFKnE0lv/TnM+O1LUlfd9L7fgIxpNvHkKsCeVR/roGd7JA6oVPcUTUTs4SlfJG4MEyCYorn9v9Fqnvx+XMTOct719EmYbhRLkpMfCCd0st6DnsMS5EptlJWRRnf9JF9Q2JI=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA1PR10MB6319.namprd10.prod.outlook.com (2603:10b6:806:252::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 18:51:06 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 23 Jan 2026
 18:51:06 +0000
Date: Fri, 23 Jan 2026 18:51:09 +0000
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
Subject: Re: [PATCH RESEND v3 10/10] mm/vma: add and use
 vma_assert_stabilised()
Message-ID: <f62280cb-b15d-4ed8-a832-83d18d6c730c@lucifer.local>
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <43c90424ba0874a71bb7ab9d6423b3a2bf616f8e.1769086312.git.lorenzo.stoakes@oracle.com>
 <fefa442e-1ca2-4f56-95d7-db135ec3eb1b@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fefa442e-1ca2-4f56-95d7-db135ec3eb1b@suse.cz>
X-ClientProxiedBy: LNXP123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::16) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA1PR10MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: facf9ece-b7e6-41c6-a5ef-08de5ab05d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/f/FgaiRIVitaesvDRPMZ2waWbr5tHX7ltxjPCCX1Y68BWEHsN58Rb1YzFo+?=
 =?us-ascii?Q?VA/uOyOu4Xv0L9OJi2yQONwfzFNavLZkq/jBJdqJ8O7ahw2/IqzIS1TEjCOk?=
 =?us-ascii?Q?MfAEBqTWM9y6g4WPUsOipIjZeN07oDzIpUn/Y5clWL+gMdP1hYR1+lupTaO4?=
 =?us-ascii?Q?AOtRBDiyAcs4y2L96RC2WJE7BdEBnxzVyXBAbsQ61xOaNCvH5zV1LhPMPz8b?=
 =?us-ascii?Q?o3MuTlsdQFylq4Ahr865XXQzuuaE6I+6UbFs8Y1ZRTX/kgMQ0dXVPqpmJOo9?=
 =?us-ascii?Q?m6xxLoFpWSM/9sOs49kQOU+vHe7lVjl2uYZMuKvLk1BkjX1+Ot8l+/zecVyM?=
 =?us-ascii?Q?7/YSSur0p/yEKj0lkNZRUNrqvo4eOPzofg8rFMiRRW90fmblnnaRUF9lTNAS?=
 =?us-ascii?Q?+6fl8jGmz5UYEs0xRpph4IXcdxMOTw8oynTHneQ6nTdbgqSZQh2iOHsWpfB+?=
 =?us-ascii?Q?pdfl8qeGWretBwg9oDTMLrbEIuloT9TWV6sOybGg7MBQbpXEKSYneKVqtaXt?=
 =?us-ascii?Q?CHiyTTiHGMaWpiKic96T2rBas85b6PUKXd8EV5KXPqYwPRXJ2belkrQL3rkc?=
 =?us-ascii?Q?Akv+gwmh1JST4eez4AFfdJDvYmDbRVyfnt8APuGJC6ywLHUfN2oGjpr30pak?=
 =?us-ascii?Q?MnDRu0rSOi0uuJn5GNWFcvhCTwr7qBkVh8ayN2RbFLw2KRYRtbXo0COl44i7?=
 =?us-ascii?Q?fdSr1nA0k3PFGfMr2xeQ1SrfXvgxMgesZnxSCwdh6e5FZi9tRkjnx+Kpcipc?=
 =?us-ascii?Q?VA4edy3gpvgMPchQwzktrfculXkOwXjeTy3x2tEX0SQm/bEnuuqR8iYQ14ui?=
 =?us-ascii?Q?PguSXRSXW7Kz4TRmXnqaylRMYlPlAvuXljLDIJPe2jD5dfnBniXjkfkRMpZJ?=
 =?us-ascii?Q?2N9tqowAHRna8GVBIJe30ojdTXol1eyvWJ1eCXVaRHUsxpzm9VnssZX+AjZz?=
 =?us-ascii?Q?18MfNdTAZk0s3PZtkc+EgRTFTWzBHeFBjUUrC6I7BUEkcOFi/W25ZXfDmMH0?=
 =?us-ascii?Q?Dx6uBho0Jd3YaOqNmlCCq0Kf2BgORvg+V+w6IWbLT/hB74BczytpA12fnNkv?=
 =?us-ascii?Q?0gpx1QP4cisZDMXt7Q23iRNrnar1rMMKwe56Z73fRQVzUx0r7zedECIo0QF/?=
 =?us-ascii?Q?bYIgNfFzOEqsGJCG2JEnvaKjvW6yRo6uc22ZMHbVX/A6Q53Tz3vtvxMYfy0z?=
 =?us-ascii?Q?D5Kpcs1+s6y9q3uiDeE94trKRZvc27TDD2POk0SSd4qKv893iGxCKSITWD2e?=
 =?us-ascii?Q?7eMVlAsO2lOO8j737xhTisUNlfvw3CoATAlyzqp/oFYpWmqr4Y1l9hfpiQ8h?=
 =?us-ascii?Q?XKaH9+fArsUtFauiswpUTEQAQvvx0RUfYZUoh2fYMH8RDRzOI+9qOHjrNeDf?=
 =?us-ascii?Q?dgNdBc9EO3OX1m4+Z7sUI+UHXkBYpEOk2jB3q1J7hgjI2v+Q1w9aR3dVvORp?=
 =?us-ascii?Q?/UWE/rJAHpLTihckm0xsgdOYa9IgkcN6aVp3asjV3W0cKV0bqJYjhRPTbCNR?=
 =?us-ascii?Q?jfMVsDwKSPiQ344YQ93ynZLrUILpTzC/u6bfMCI5/sHNv+HQVoYwdANzTltz?=
 =?us-ascii?Q?1YnhPg+RCfdR12wx+mg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n+mef84SKtnsPwRTraDPIDIJC8Xn32rfULua+ldUWX8PLWiz8fO5JTKOHqFI?=
 =?us-ascii?Q?XAEd+nZEAd364YEmJF5JSNQTwjHAzklSfLI/7ezRDXD+eULzUqFSKqtzLwM0?=
 =?us-ascii?Q?MOCsiV9TixWac1ntOp+C/748CZGZ5o0n23x7Uh9OkBu0MP91z6krFpuSQ+or?=
 =?us-ascii?Q?YNNOf9VvMnBFUtFEhGPAkMOPXa6vrXXvchRcAoO/Y57oTqfAnJxre4D+ZjhZ?=
 =?us-ascii?Q?EyOGJSn8qwfh0ma3WC4IfOKMHpXmr/3SNfed8khrMpTgWMcvK0HPJbiplv41?=
 =?us-ascii?Q?QxEPrPp+8ZkteC4oCIPj7GMGhw3yCcM3Vn4ukg/Sjhw9DBeIgO7S1RhsRcW5?=
 =?us-ascii?Q?tX9nBZmVtEcT+gsiYdVX1XOp9hpHHKVMMIqFsu65VI+9E/WmxS+XWKzpqcWi?=
 =?us-ascii?Q?Uicn/mDJyX2W3ePnZ8ZNthiUlcbcgyAejvoJlwXtH0WJHrYsmrr7kvH5smx8?=
 =?us-ascii?Q?p3mK3EgpM/0M0XDzEF7u/GdqN0vdXURHeNG6jZDcD4/qv+k1pqAjQj4f/hzh?=
 =?us-ascii?Q?eMlDC7dX9v3KCT+JPXLFkPWbHXp92J/NtfQLmc6+VVOCiitU6XSha6E3hYWr?=
 =?us-ascii?Q?C/ambNPQ71IaAGdJlMfkNr8F+5yvajoIbK79zFexHHoFVVsZ1dYtUzCg1UwL?=
 =?us-ascii?Q?qaWReuf19KC4n7Wv0y+Rx+D7Uu8bay7C98Vro9J2oanGLp3zCu3FlbSpvOv7?=
 =?us-ascii?Q?jHX0GwOP5CLgl0/APzG32pTRnP8ttMgFSBn3EYkUkk5QZ5d3vgpB9B2eyF93?=
 =?us-ascii?Q?z8lrZXukz6q2rLc50nCtfF8h4NtlHg85PnwTkJkCSoyI2xOGMM6NxgSh64Co?=
 =?us-ascii?Q?E0+vCyhse6ey3zc94Lon4ad3Sei2p8uBp3wGnuXdhIsWXvhF4ysVmZpR1Tm/?=
 =?us-ascii?Q?CB4rEwdYgzOzKHGm0tNLrygShxMKbVgpe7OrHg4whE9SOR0agK4gMtwBBC+v?=
 =?us-ascii?Q?EPX34yyM7LZxrpaXshG5Z4JbvTXth0A5TxPb8EejMc3lGzp2Nq6guPjWm59M?=
 =?us-ascii?Q?qmKJWIXjrAgYEBnaPcLVcvpYcwKZBrO74ueyIBtW7x7rtOmijbuvLP6cM4JB?=
 =?us-ascii?Q?+uG8Fk4+4bbKtt3H+EmdjzDVrJI553+ScpbqU7aKpKW2Zv15gX3Hd32nmqae?=
 =?us-ascii?Q?btvsPfpLW3VNEHxwnzuP6qpDm2gUONGH1FgSPBRnVmAWIcDUJQ/Iaectu28n?=
 =?us-ascii?Q?eOGVDJobnXGY8X6pLGkuZpCXtZGKW6AMobgIXT7Ii8vfxHq5rsilibV1OkGY?=
 =?us-ascii?Q?+JlZDlXvjzGJ6m4D2sKbbQ6FYDdWEi0BIPvNIYcpmGEnhZu47ILXEkxqhnfl?=
 =?us-ascii?Q?cxer72UtuXcAsIhhCCWYpIgEN0uyI3cN66khC1rH+sCV/jInCIsvta0ov1fC?=
 =?us-ascii?Q?tcgu51VR3JBzcrETHIhFSN4gzxPXW07nvGAyhcatuhR4xQI6Xb7J/8bDLRSS?=
 =?us-ascii?Q?wwAdnbsjZia45t09AHcaT8hCSpa/efH6Hek5xTl6yPhTWodBAIYpWRn6IQns?=
 =?us-ascii?Q?r4t26G+iaosXypyeT9kcruS3vFCehTlykjZ3BHk2iBRNTFuIXPbzhv4Rfb1o?=
 =?us-ascii?Q?bi5uQ3Vor0NR2atjq4S9vy7DOsSAsibnhkFGjBz+MVY0O7YmA2oDiAKhQIY8?=
 =?us-ascii?Q?ECRTvoDIfxG1poFf8OflbVpJItN+MTiUZxNpRR6WVeczbutP1ABSX6gXajFl?=
 =?us-ascii?Q?8EIEFoB37x+eMedSlFozkGNJNIwkTD4N8AghfLQh6Tldv345EbIx/W3RUXlX?=
 =?us-ascii?Q?Z6VGXAJa7BU5YliLsSPLuStGEmKVj5M=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MEg6814aP30vfGstq4XVRl6x5sQvYIH/qfV4DOSDiSA7a8+tgCv/q2LZBk5+aUtgD56lUzuwt2YgRiIrRUDULfP+HdNFwdIakilzB9dF0VmbdKyD30/wqzaS7nwxcF+TLJyy945Ty+2xteoljbBdXs3brwXDib+BsCE8KCgarXODDnHCJri8WbcoDUYeL0p4h+vsDf7p8NP11kXdKp6P+zQjF5Il7aZRDcTpE0wgR3oBCTIcT1jki2iacW6OtPocU3SqPFs/S2QjdBbyXz4QRm9Rxm5eK+miL37J7dv0nXsLCOVJdEOG1dNWW3+7Ub0S2Bz259TJV/HbmHm9dPwOEAuBmJHi2EqaSg6oH1xXEzBn+NXJDRY1Q5xzusSNUMH2btZJ5PrFz1nCncVfaqGW7I4T7BHrcCNNhW/b6BbP3oedhM8lBRAPAG8X2c4KLyjUrT7gatpx0M3mfa2ZS7Mg035rZcmy1nC6pdAj2CCgUQr7VkukNQ9AmAygMGCkMW6PzP9hDVG9TTy9R3DChvPzxYHsrIjJPyMnloTYIWgxoCqgvdyMRbItJPvzXQ9tU1JSoQr4Iu7QVgPtIaYJ4hkLpjtfYRC644QgzwAT+IpbEUA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facf9ece-b7e6-41c6-a5ef-08de5ab05d79
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 18:51:06.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffmrj7z6tJHaNX+2bd8UdXpi6rScCeIlweXhiudbmIZyNEBKQf5K/TvPb2SYn/5IKzIVsMwF9GJ6YD5589/qL1zZDEbGmmeKJSu4BVR4ZNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6319
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601230143
X-Proofpoint-ORIG-GUID: deX-ZhTt6oR9UmutHBSeGtPZaZmW6OSi
X-Authority-Analysis: v=2.4 cv=IsYTsb/g c=1 sm=1 tr=0 ts=6973c320 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=mSsehR9xUSn0Bdz4y7UA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE0NCBTYWx0ZWRfX1+BwhxgQboiT
 O8LZ6TT2uKBD8nxRJi/A1YmsAeB1efENJ6fZHI0Y2Ecil6hltT+jLaA7IWyFxZ3gca/EVdsPv+j
 sO1xjNcq8j2c8uCZkNiwoxJ3gGJu0RDG/O17VwvaAd8dv6GwrzJ/k0EqjRD7vzZyA9kS4/jcQQE
 8632UIs5TAfXm+9UHAEQnLEV2JLgVaNCY0Uljhc0v/osctsuGlLX41b0QQy5cVKFkZLI4j6RuF9
 IZwHHpsfX6lRlW15qVRDD/UX8wkDBQO98yp4gwmWazfnVBfOxpRmxIcBaBh/uG3N8nslxQjf57X
 tUxDry3ro6OZtHhGDMMqco15kiJCnvmKQ1VAFkWpWqByqbdIAweDztTa4qpHEhHpn/4GnnV1Eym
 FRv96cpX7exXlAcBv90The+Arff7vzN4rAD9v+CNTKnAtpcjsckUWQdg43FISZnTWOTwqyHx49P
 W09sVvdoFK/6/FNTrCClPOjkrE55721L5lOSArU8=
X-Proofpoint-GUID: deX-ZhTt6oR9UmutHBSeGtPZaZmW6OSi

On Fri, Jan 23, 2026 at 06:10:29PM +0100, Vlastimil Babka wrote:
> On 1/22/26 14:02, Lorenzo Stoakes wrote:
> > Sometimes we wish to assert that a VMA is stable, that is - the VMA cannot
> > be changed underneath us. This will be the case if EITHER the VMA lock or
> > the mmap lock is held.
> >
> > In order to do so, we introduce a new assert vma_assert_stablised() - this
> > will make a lockdep assert if lockdep is enabled AND the VMA is
> > read-locked.
> >
> > Currently lockdep tracking for VMA write locks is not implemented, so it
> > suffices to check in this case that we have either an mmap read or write
> > semaphore held.
> >
> > Note that because the VMA lock uses the non-standard vmlock_dep_map naming
> > convention, we cannot use lockdep_assert_is_write_held() so have to open
> > code this ourselves via lockdep-asserting that
> > lock_is_held_type(&vma->vmlock_dep_map, 0).
> >
> > We have to be careful here - for instance when merging a VMA, we use the
> > mmap write lock to stabilise the examination of adjacent VMAs which might
> > be simultaneously VMA read-locked whilst being faulted in.
> >
> > If we were to assert VMA read lock using lockdep we would encounter an
> > incorrect lockdep assert.
> >
> > Also, we have to be careful about asserting mmap locks are held - if we try
> > to address the above issue by first checking whether mmap lock is held and
> > if so asserting it via lockdep, we may find that we were raced by another
> > thread acquiring an mmap read lock simultaneously that either we don't
> > own (and thus can be released any time - so we are not stable) or was
> > indeed released since we last checked.
> >
> > So to deal with these complexities we end up with either a precise (if
> > lockdep is enabled) or imprecise (if not) approach - in the first instance
> > we assert the lock is held using lockdep and thus whether we own it.
> >
> > If we do own it, then the check is complete, otherwise we must check for
> > the VMA read lock being held (VMA write lock implies mmap write lock so the
> > mmap lock suffices for this).
> >
> > If lockdep is not enabled we simply check if the mmap lock is held and risk
> > a false negative (i.e. not asserting when we should do).
> >
> > There are a couple places in the kernel where we already do this
> > stabliisation check - the anon_vma_name() helper in mm/madvise.c and
> > vma_flag_set_atomic() in include/linux/mm.h, which we update to use
> > vma_assert_stabilised().
> >
> > This change abstracts these into vma_assert_stabilised(), uses lockdep if
> > possible, and avoids a duplicate check of whether the mmap lock is held.
> >
> > This is also self-documenting and lays the foundations for further VMA
> > stability checks in the code.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> LGTM, thanks!
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

Thanks!

And thanks for the review in general :)
