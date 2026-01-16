Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7D202997
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578659; cv=fail; b=UklsXchJH0kpaq92ROVKzhWC66xENh5Ih23RQb7bP/GGnoSSgKGhkSpqx0XcGAakokH3AeNPSMtzjffnHgry8aXgYcKGFjT7de9Jhr/0G/XAnaFlZWmOSp9H2oE8EnCdgnggf3mWQneJ3tshbj+7Kpapkb7i8fNacPImHfqKY68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578659; c=relaxed/simple;
	bh=BJV3GOfJyNEAR7HdoEPL+quWutCrIATP/VVGzQXJlew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TF2D0F+SU/7FUxluEep2mD/547DRHaVMXMeHIO1aySd8CWIQ4SvJKACV8azkpNCewldIwa4M74bIISG68wtPL13HG3pEsrzg5kkiM9KLECGw82fvhVMrnXLBhuErQk9k/fKHXhG4xAYfpOOf5xlm+jOv/0dT68n5P76SfLsSr0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U7r/5xCs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RYMdMz1+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U7r/5xCs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RYMdMz1+"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GCuCRx1796053;
	Fri, 16 Jan 2026 15:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BJV3GOfJyNEAR7HdoE
	PL+quWutCrIATP/VVGzQXJlew=; b=U7r/5xCsvYbNBYhn+j/xQIrL5YOcZfxx9z
	2c+HJue27pHGGHHat4cd0zU3kKFVFQP6S/szBoo4TFpLn/AMNhmJ06tZcgI0Xv1X
	ozFUcxzL24JJN9Dice047VM8dpW+NBTQWFmCGbv9t98sobKlHuplR0ng8ISfADtb
	Aa4vaQTxp2d///u2tw2YLhq3Tw1PJHHW76yeK8vVzm3To/2KVeqHvVzPOtzilFoU
	UBKKzCdW0eHtaAWpgv0msr3JJj2T1r34jJpLw5mM0XmhXDZD+rOigkIgJjpFa5xX
	hoql3bVibDtMMQ/Bi9hCHBcAkW0vRHm6tGigg0Cec+bnkvwrIGfQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkpwgt4ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 15:50:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60GEsGfq038038;
	Fri, 16 Jan 2026 15:50:25 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7gu6wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 15:50:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVSohLfQd/F++cK+iZAkfuIwYdyJqCWhRgPMeXWp9blMUuSpr6vrIEaQafyhC1zHK+L5yhCvysc/8nJbR5b/atben3lorX0M1coEcyr8ACYGV9210omFVyiNAiB4aBvHrdc3YhQIX+ZEGEpgN8JR6uXaQr75LSppBD9F/h3S/1DGSIDqmyid0yjNHRuou9nIitn7lkPrGR3ZxTR3NoC9yaNTZKZNsPkIZ8xIrHAfItOIdaWUlGFNRh8wjLIe21o4WVrQ0zBxB7Em8N5LxIb5+22BEONWTXx1J9NBNXscfTwXovkhtcCNt8JM9TWl2fybu7OnYgz4P0Najki92rOo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJV3GOfJyNEAR7HdoEPL+quWutCrIATP/VVGzQXJlew=;
 b=ru6prkBSJ2fYSwqHXTz87gLAF+6rcIm4JEx9+GsqkxqRt+CNEQZT4FOigPUQOwnl0puj+Wrfzpp4YYdOwUlaYMtRdWrd7EP6rHn2NemF+KV8LAEK7sioAhFbyNHUvvDUSZQPATJOS5vBKlfGEdFVRxOJzTvNiUvXMMfKQp+xteR8CGqwOLcV82zc/Y/F4zKmAC6mEwah/stizyrYPe25INYy5+aossHGPqHWZlUXMGgftZjbNreLRCXoi94xCoy6NcNy/fLsNjmLtUlP3S8izGp7hIGF30jgeRqTe+yGV9mY8GxwwaQ9ilNYdiKDDCcd3Bu8iSrMKgAtImB0rf2qJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJV3GOfJyNEAR7HdoEPL+quWutCrIATP/VVGzQXJlew=;
 b=RYMdMz1+vkHfpDNRBHwa/ReXVo1c9n6blktEShuiVT/sA8HPNUzPomipZPK6v9/Eji9YzQInEAaWsdWKFDv25mBjAEFDCp1r3FHtaclPADayeLoEiua+zwPKBmQl9kUk1hhIwYq+noFnYfYwidQRc8ciMXW19EIVJUx/4kAZT9A=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS7PR10MB5103.namprd10.prod.outlook.com (2603:10b6:5:3a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 15:50:21 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 15:50:21 +0000
Date: Fri, 16 Jan 2026 15:50:24 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RESEND 1/3] locking: add rwsem_is_write_locked(), update
 non-lockdep asserts
Message-ID: <99818e30-9f88-4751-af82-0bed019156eb@lucifer.local>
References: <cover.1768569863.git.lorenzo.stoakes@oracle.com>
 <8e343ccb9319433364f5949a69519f1bb521fc8a.1768569863.git.lorenzo.stoakes@oracle.com>
 <20260116151215.GH831050@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116151215.GH831050@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: LO4P123CA0088.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::21) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS7PR10MB5103:EE_
X-MS-Office365-Filtering-Correlation-Id: 00eb3873-e535-4e17-03b0-08de5516f4b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vnAJm5xpivCygSh9chQht2MaxBNx69uG0mRhlFibuucFQChEmQaSIGCHvqhY?=
 =?us-ascii?Q?nXp5XwlMNN5tcW0xUDrgSfjfwzd6AcwM5WiApeuZVE64bXvBk3LIL2Gw/kd2?=
 =?us-ascii?Q?D2tvM0SPH7n2by/iVb3Simcc/FR0gBaOpNe7JtdrkwJbBfD57aq9tnVCmKBb?=
 =?us-ascii?Q?Ol7dX711hEb3JPuoWq+K/CUg4HNOhU1SmMBMzTdIFawW2V4CrfFCUHTEXrKX?=
 =?us-ascii?Q?6DKEKkQu1lSOAlkl7xwuRyuR2CtZIZuFS4m+MvP+7wEpX4+Cu/T4KdHyvBsB?=
 =?us-ascii?Q?vPM9OBXingBzeRYQsKSuDXbZauvY0pv3AON1IDIZtjYCaT0u0nX1DmlWAe3i?=
 =?us-ascii?Q?wGZHpP8VrGnDzr/i90jHNCbB6Zavha5IbRKQA/EoI+w4D+zvEpi9mIw8i5y3?=
 =?us-ascii?Q?B4nh+FlKQKsmXEbH7htTFGkvfrrZQPCmkeoSur+ZLmiHDTsVxiAKU6jMU8VG?=
 =?us-ascii?Q?7Gav9StkIeLTQFkKJL+gSNf/WWTeOEeVXFf7w7l2DxLZXIdDbvDR28LsAXnM?=
 =?us-ascii?Q?CuM6qBGTeZXxaVv6RGhHsPrsB/CdOyIKpOgF8jzFp2K/NflrUPiT7Q5A1Iia?=
 =?us-ascii?Q?KlepsTfsMaJnIrIgR/BflMLx/1hPbHcBINsxilUzP97zRxXYKco8lM0qAIfM?=
 =?us-ascii?Q?YK77mLwybbA+B6RoDS5e7xap8PgWWMIugnx7dOe2GniHP+4Mrcivg/cbMD8e?=
 =?us-ascii?Q?zMZ6Gmaa+cdkgOFyYWM9OWvl9eK0Q+uBQmxj/F6imnVnEJVoJWo8rjgjVyKg?=
 =?us-ascii?Q?wly4I/j8j+K17tXqTlb94o9/Ojwp1IXJ8CxNlvTKI7WsqPvq2rjNIunR9Tvt?=
 =?us-ascii?Q?wGbFIOvqFW+0vmF4MQXVmNxVn++ssJYYiTJLNXlwg3UyNniXp1cQ5xGHlHTC?=
 =?us-ascii?Q?rg0XGrbKuOgWn0afFSRxLIhJhYjpAhesPYbYjISnSaN29dNRzl9KAhWYXfm/?=
 =?us-ascii?Q?/VEf1NtFRe+FEY4RUgae7O+MiL1sNYn+aktTNP8xsCoVc6aViZ3xEQDNUoTz?=
 =?us-ascii?Q?1pkWxMR1H9Dyy/QtgZV4zpbxj4fLHXoTFC3QavL9o80GsaMeZjf1CxdIOW9o?=
 =?us-ascii?Q?2rfP55ebhSXG7F72v/S/cDg7s1WtoD6fPZPyRVczhaQhFLyXH7VBZm8CDok/?=
 =?us-ascii?Q?i8l0/k2TvsXNktuPedmpOqVNkD7jqtXT6cDkyS6py7hTat/4UW416IQ50WIX?=
 =?us-ascii?Q?ZmwvODLqj4LcdxSnFy44H7BBCHn89zcE3s1wJ6vLRNNGfBalomYeqyvil4li?=
 =?us-ascii?Q?yBiNh3hHninQk0TugI0p7z5+5Zsq3u8iJg3bXYG091ug54nUMOg9CWSj9QFg?=
 =?us-ascii?Q?goGlo7myIGbTKS1rPahSk6jSJGiRxfeV0rQQJzzWO5tQHYZo0Vv41Xb/uJYN?=
 =?us-ascii?Q?6WkXbG9AAALxMrji4/rdLcrCsgEOKRh12qSYAlbJL6WycbuWcevmSWI4cqCJ?=
 =?us-ascii?Q?EIIq7GJ06EnynuLLeHxtmgSKCoc156tcNRKVMHSmTEGGRtVg64o1mbv6BwhR?=
 =?us-ascii?Q?qMe11HMpZ9SdLL5/16ZXtgrveC858l6vPQQix6NW5ROWwzmJzr75s3QNGhTt?=
 =?us-ascii?Q?KA259nq6qoB1OGL82JI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bckYzsHTps0AdxclDfJxAP0nWLY8CBiKAOhm6gYGl/SS4n8Gcu2+wv+2jYxa?=
 =?us-ascii?Q?74NSpoehNe8zbYJM9MIGrYR/B4IzMvW/0ph2FMN+q8jPQM7Gh3WuiXD6K05g?=
 =?us-ascii?Q?0iP8/4fpkhduqGOsBCvC9UKznz1QFXrB7Uk8F11DaZ9nqk7LWKmjRKZwEMlj?=
 =?us-ascii?Q?2R5GbYcSr3kAuJ7sMliKcmqQzIlK7hxKH1knc2I9EcMtvsvyQbRqcjbr7kkg?=
 =?us-ascii?Q?ScC1G+GLFhq9uy7hlwr8FBHJNAmXh+Gy0GZ8g1ZUn3W3YXV2eDl7rucKVEem?=
 =?us-ascii?Q?ge/bIHtsj3mt+8l8fGcNmdzNYD+TInFM42jaNsHNRN2g6c2+160UdPtp6Vws?=
 =?us-ascii?Q?ElLoef4cd7V97z9MTeLG329yQnvY955RiInLlElIBdFJcmXoElzcO8TuRWJu?=
 =?us-ascii?Q?AqO2paJamMh42Y1UvydKT4BrLelOg30KGKQ2/RJwVTYVGKiwqc7UIu7RAAh7?=
 =?us-ascii?Q?EfomlF0oy/rDhrPN4BH8S6v+/WJCCZRkjjUjZly1aljFCYgmfqUCunLnyqJg?=
 =?us-ascii?Q?EEsFaA7T7mQ8TAiojgZB5O2f2sSMDR7GxtPIKLIB7rXYJTSkvI6Y3qTf3qjY?=
 =?us-ascii?Q?RI+HJkq+yIvyuKRTbj3SE40BZc3Z/auWUv++2x2cUxWzKix5b5QDZSEN8hf7?=
 =?us-ascii?Q?U/jPxstdh9c7dP85D2fCAbkPhLIDl+01PdcY3OjBK091zHt/F2uhgOwSUrOq?=
 =?us-ascii?Q?i80qaLUqvHMBNjXDjs6hEDolECQWZi9DU7OOwnrXkRY5CnhDap1Cnrv6i85x?=
 =?us-ascii?Q?cvfMfuH7Eg0iXBxu6mc/pIwBJZOLJW/R5AgMALtthrqbvAjRLL3MReaLEWmI?=
 =?us-ascii?Q?qdteDTb9vF980bKtNrdgemHXZccBOfCGF3vmZUbybnwOdWLjo89/QyTWFCb+?=
 =?us-ascii?Q?xHSacErzTj7FJOYmBpccwFSwLMAmrjy+PhsJwmwJOrErnL/tFA2JUfToNBgV?=
 =?us-ascii?Q?BJinP5Fqgq7CTzucq8Bf0ensyyALenNjVO5sJHdr2iBcCM2PFwNXKGRE4CHQ?=
 =?us-ascii?Q?muEAtLNk50kxsgOcPCqCAVVe3svvfDotHITgY9lOrK+F9jZ/+S+s6iWaUAhc?=
 =?us-ascii?Q?mSt3uD4kgaerimXnugDSNhLYB40x5EPJxM7ryYCmZ+VqPPNNGdwl1F+3MZ8W?=
 =?us-ascii?Q?EGHIqSOOYpPSMWd/K9ACzOMVonBE1JLqd9N/eKg+6eP01j+MIWH+ZGOcvg5A?=
 =?us-ascii?Q?lId3UPHulYNVZvBHuKo85KaPqMqYCGGvvRYHTWMw+Ef589AwDXp3P3kDAGXX?=
 =?us-ascii?Q?6C48SxQTMiOt3AC7Sgo96Movix3qWFCTv98kEnelguCacN3mKsm5L8ADALca?=
 =?us-ascii?Q?s+q4zHXcLA74Ekot9SNvxWU6LYSFE7tnKx10S2zFoOTW5kKH8FCmn1PxOVGO?=
 =?us-ascii?Q?x3TXKbGkFheERcQxgPZQUc4sIoGC6PmeEI8BCQDTf+WZuprhp9b7FABAhiKH?=
 =?us-ascii?Q?Z7RlQHP/t7m6VGheMye/RgKOWq8RgebCbKzvCVDXCnM+m6XNcbqIWCtRkjQF?=
 =?us-ascii?Q?YkcAJ+yUiRxGLufCCgI+Ri17QOwFJ8fk6D+dTEVToDacvi62/nMVQ8sW0KTX?=
 =?us-ascii?Q?t8QF0nHnFvKRHm/nVGLGc+NeMc0fQ1bSp3IKVA+KvJDuxSiPS9wbMfTPji7O?=
 =?us-ascii?Q?vjCphgBp17tDN3WG4IXPe/oyXBrxGq1ZorUepZ+9/Zu2z+/sCkIoVejzbiEn?=
 =?us-ascii?Q?V5nerCkma7upKC1lW9vGvOgp+rEfTSaj1PNkbYEdkP616YT4MLJt5aCJ1qI/?=
 =?us-ascii?Q?W7opso5a5KrWfLyLv48zhMFwB12qqZU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tG+JGVi63Hn5WRK5ossw8bZ9Li1qNz5hfTN7d9PGOj2BLlZxiropuQgRbhOgh1LrtF2E1ftcnyUNtsUjRBCZGICGcJMv0Qtw7318drlPuGnycVQh3zRNiSmGgDASFm3vtWYBcnPecv0emIy3+JX69S6scMPQhmjtotyO0NZwUvCP+fc+eeGnVT9Ys2rt7kYeCWtoqQNBeJtGMCuzTCT4LivIBYbwPM/mUb10eSf0cluqD5DUL0WOUFsBBFCEBxuLkvxVOcvLk1JKpc7wxEgrmPMpKRTSM5juWaLnQa/g/D1PLMIBuIH20aocGAGrX9GTanS5gWCh7Yt5oK2BWmr6QvGJjFTulbCfkN5cNMgyvJrjW2aVKf12r7IiFNrtATuen3yeGj4nMDPG8dW/dYoCvRgVGRXhxkl0nY3T5y6S7slqQHq+PtB7UjcCTDNEXOu6xOshXCpqbMStANr71IFBvsr1/GtZPilkFgYDFHYSPV7yp20nQV/t2ZOmfusJpA2VkiJgU2NK77xvVIRib21z6cmj3iEhuqjtWFjs/XMtYNEPUNbCmYwSBtfZgJo5zQPgKYNmnOv689MfrbmNEPemZnB4FzIRNyzLnE9aIXg9G/g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00eb3873-e535-4e17-03b0-08de5516f4b1
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 15:50:21.7438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxTweXzAq6yd6Q+a+dtmoiVodhzvpaZFVnIzNniQnnd9mX70N/BMP2jQ8V3Ou5Rp+GWN8/dbXCoQXTI3UZ7Y+HxnRWFBaj/sPkVF3PeTsQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5103
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601160113
X-Proofpoint-GUID: 0SzvhrrPpz4QrU3pfLGvz5-_4tJ7NQse
X-Proofpoint-ORIG-GUID: 0SzvhrrPpz4QrU3pfLGvz5-_4tJ7NQse
X-Authority-Analysis: v=2.4 cv=ZtLg6t7G c=1 sm=1 tr=0 ts=696a5e42 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=S2hcFFM4D_5tXpxiVd0A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13654
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDExNCBTYWx0ZWRfX+VsrmcQ0imzs
 fXnAGsk2KDsl6DiMuq0XFMvB5ZMqT36qYBGmAPn3SabUqRFql77YymykseJwfrWCoCndQhqgl4Z
 slb2ZjVl+mmJjNmsIcwWa5gEHdJmkxgjJ1OtfPJ4TVm1cMha7N1+i5Dbw67pZhvfEhKM2L1ACdl
 aaYcQvmhlD1wgEEt/JmFLWGySlkxtZNyko9kiEprC/thKM8vELTJF+TOJnfEA9X57bSLOOy8QqI
 dq/wLssTLYifsO9gaHfWK61tcUzsk42B1XK959tzlmjSxqe3ltI+M0N0UJJRBndTNkP0iA5hvYJ
 K02ZQpeFdNaj5Qrc3yIjDQ6UdK+dyeAZ/olhJk/TEY+/VO+/dpG+0DIzS2obhE8SGhEmog06Rci
 rSi1EgHePPhmB/YOiH4VhgmGiyUrYWFoRSkmpU7ji0YWNvTZ9zy9EES9sMYDdoGSMhxLAt+fKwI
 C6eBsys3VlB8elyoRQl23VR/7TkmkYAIAS9G9vq8=

On Fri, Jan 16, 2026 at 04:12:15PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 16, 2026 at 01:36:45PM +0000, Lorenzo Stoakes wrote:
> > As part of adding some additional lock asserts in mm, we wish to be able to
> > determine if a read/write semaphore is write-locked, so add
> > rwsem_is_write_locked() to do the write-lock equivalent of
> > rwsem_is_locked().
> >
> > While we're here, update rwsem_assert_[write_]held_nolockdep() to utilise
> > the rwsem_is_[write_]locked() helpers directly to reduce code duplication,
> > and also update rwsem_is_locked() to take a const rwsem and return a
> > boolean.
>
> There is a long history of abuse of _is_locked() primitives. I don't
> suppose you read the email thread that led to
> rwsem_assert_held_*_nolockdep() by any chance?

No, but we need to be able to assert that one of two locks are held and we
don't want the failure of one being held to cause an assert when the other
isn't.

At any rate we already have rwsem_is_locked() function from 2011+, I don't
think it's overly egregious to add a write equivalent.

We have a specific need for that, as the VMA locking logic asserts the mmap
write lock is held before you can check the VMA write lock is held.

I suppose we could rely on the mmap write lock assert in
__is_vma_write_locked(), because if it's not set we want to assert, but
then we lose all the neat and structured design here...

Would kind of suck for vma_is_read_locked() to not assert but
vma_is_write_locked() to assert.

Really I don't think __is_vma_write_locked() should be asserting like that
anyway, it's a footgun to make a predicate check like that assert
IMO... but that might speak more broadly to the overly complicated
implementation of VMA locks we have now.
