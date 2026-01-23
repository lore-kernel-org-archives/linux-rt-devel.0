Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D38E55A
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769181073; cv=fail; b=KosRCFgmODXIRhg/NiHuVDrexDAnTfrKx1QRVmFBG2pPHxiX4O2o3n+AeuvMimUsR1rgUSh3YJ8tMrYjZ34zLOoojqYTs528t3gyVsqpZLtB3+59suJZfLCVSKepKagf4NxSpvu/QtXvC8z4Hr5CMzpXU5mgEzfVgSZrEmS/+xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769181073; c=relaxed/simple;
	bh=/LFynuZ8QCNSMAwuyJmWMh4J5/Suq8QOXiXR4hf/TmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CFxS0/82jG5PG1e4FO9Xple8aDQO9hrhrph1LD6u3Z51YBSjYYg1NNyS9wdEdfLhdc6hBzNQh8IZkaUWCzpOs1iQdK0mCtlerZC4unkwqS9DsuRoWNy0JFUcRE8q57FrW9/zZQCLGFmcMeBwCs+D8dsqjFJb6hLD3ojTUR/B1qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qiC3b/cV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wRVl1aXG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qiC3b/cV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wRVl1aXG"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NF7eaE2973460;
	Fri, 23 Jan 2026 15:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/LFynuZ8QCNSMAwuyJ
	mWMh4J5/Suq8QOXiXR4hf/TmE=; b=qiC3b/cV+7//SyZNKu/j4S9OjuaNpANpBe
	zQ1A5XwkyzHyQrwp5uKfoe+VjZ5Lj0YluzXaFyvYYyE53kjSrxBPFex3NcXhHZ1B
	jM3xo0GsXk+VUVvzuEbbiTzqu/6RoTSd+bmIdfUwkJ5+VXfxZBWtHK2x8yQpJIcH
	WyIUVlA/TWdzzoX4Ae+wpsdHffA4GhY4G4F0Sk/EIZOeQ6QG3m1iqfFrv8nOVtfg
	gou6qS68DPj/p4DMM1yiVVdEU2nA4O7bhJh8msLwSbxvopYSO6ZVjlcKlg6MwFgp
	Kd6Jqm9PtyU3Ql0UKL9Q6xeeuIv3RfsE++XB1FrR+5MDCU25ampg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagcy4r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 15:10:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NF0GWK032956;
	Fri, 23 Jan 2026 15:10:54 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4buyvexxfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 15:10:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/Q79+pvj1eVSft4gb5fFFK8POfdElJBDYB9mDLjGYWzSncVByhU8+e/BjFSPaYZ5mopUbuF4rCgeDBKSnurOpEItf8Rxp1i6VMjeBz5HI+W8cJ5WQlGbYd4y6xFZ/PYXh9kR4ICKI/KFDFwh8kN5rks9D1f0Crja8CoMz89f9LElXYPtXxGrMjQ0KXhFk1UMIGEpmE9tOJWIX101nKFSE0QpcpwD+WgxtBFutuXYeYfUNKmXgdcVaMvWguVZ5/Pfr54riatfmSwcI26oQ4uBQh2lqmjRKTTCJhMIwBwd8UzDBDcIJesytE2s79cfF7WsVUAQceceWnZSohn+iMt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LFynuZ8QCNSMAwuyJmWMh4J5/Suq8QOXiXR4hf/TmE=;
 b=yDR4s8HWKZ57F2rSGTQ5MLEPKfQ4zTfrfjMuBpcaQnZZ/qM6Gweczh5auSLstjAfNcNyBL3ZshlsDEXBfP/sax6tTsCuWvsPe8/wlY8USPPM7J4ePn+8oJPTS7v0SFWguNr5vmlI+9+15wkn6eRJce6qtRjQTWe1gLtRx/vYfe+oq8FEIRs2/htdeeeo6yZM1Uo6JAfvMXDO7lwkqzbF/jYdRTaryaR8ejzSQFDqUNU2yBIgf2h4QWg+vtgQUjVe3Ky7eqQuWtlSwN62ZVydQ5HAcg1cKBrEHmUjixakB6AoyTxQ5weEKeJaxSNOl4irCJNZEFYxucMVIVcrZzvHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LFynuZ8QCNSMAwuyJmWMh4J5/Suq8QOXiXR4hf/TmE=;
 b=wRVl1aXGtfQNS3tpbonIXMusJgXJv+4wQ/Km1vrynGGDnqm+yQXSMazHiwLJRmoTym8cEoQusD70IPTu+j5Eay9OE47eiTWMPpj6gCv22LsFlVkMIx41yedczeHeZvCMJWBEX1GqbJROvCgCl3HxsxKraPHMvDtehv7Bp8sP/34=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by LV8PR10MB7847.namprd10.prod.outlook.com (2603:10b6:408:1ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 15:10:50 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 23 Jan 2026
 15:10:50 +0000
Date: Fri, 23 Jan 2026 15:10:53 +0000
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
Subject: Re: [PATCH RESEND v3 05/10] mm/vma: de-duplicate
 __vma_enter_locked() error path
Message-ID: <ba9f3edc-4003-4925-a995-93ade24a96a8@lucifer.local>
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
 <2611b2b6957b7aef587e9ae62712a888159dce60.1769086312.git.lorenzo.stoakes@oracle.com>
 <04bfb078-be50-4dcf-9838-f0ccff352d02@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04bfb078-be50-4dcf-9838-f0ccff352d02@suse.cz>
X-ClientProxiedBy: LO4P123CA0495.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|LV8PR10MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: b8948aa5-1f45-40c8-b316-08de5a919826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dgZ/MPDrXZ7ADr39/rNIGkTuxeUAIKUGjV7p9lmsz5pUY9JhmrH9WR6OQMrf?=
 =?us-ascii?Q?X+uswddoA5eoA5KBoBIKhGc1lX0XnYBnkvXb8taK4e/sNd/lZRJZ8Or+/lDZ?=
 =?us-ascii?Q?dwbO8G9nknOEZ6qO2DFmvK4CqxgqPrHAWrUH1dW7RgeAdZugwXObQpXw84o9?=
 =?us-ascii?Q?nYwnceFArErhbByAWv0cgJjVEqzGciBLxLOaxWUI2EZvY0IG6NkghDn9heFJ?=
 =?us-ascii?Q?PZZhrGge8KnolAmPyjQchn6HqzHH2vcnMvycuxqEprVhRB+ZPDS5Jm4tkuxR?=
 =?us-ascii?Q?nKGcSHP/PTrx/68sbEetkkvBudcbiryy4t2GlbkKowB+tHRqcIw/B7C0vhZU?=
 =?us-ascii?Q?oOxblargdPCjjLsC+dL3gN0X10W6/NbSdy2NDPuG4MtnRZizo6mCn9Ojwidy?=
 =?us-ascii?Q?vqDjYV0XDCTS3TbdZm1r8MBAnhKA+wtBEtwTyxeCd/De5yuZIu2IxK8Whyou?=
 =?us-ascii?Q?sSOLg+Dwz8qXNakyEDL5FX2BIx5iNJjhUM8X+mtP3cwhTfG7gRIdw2Nj3wkX?=
 =?us-ascii?Q?33P+SmgjJigT7eorT4xMYc8qXF0Svd5wekzK9yvtSnQcoHFaBuNIxHQCHW++?=
 =?us-ascii?Q?oBnVr2cwVOydp5utaQx1L8kx9j+HJa3FobkED5Psx+vRdNmevtFgc0qUGLcB?=
 =?us-ascii?Q?MdxJbveiOTn0dwoAkvInPWMfUfAwouGJrGZVaC6qX8mqc/UUhJzJ9q00fxky?=
 =?us-ascii?Q?vZ6wJzdfDFTroaeGJJlnQyCAStsx3GUYqMUl6iKDa7SyNUZSWgRmwJd4KIL6?=
 =?us-ascii?Q?QwbxwK3dq9pR70mknI03EzT3/PHJ7HY0A/7EPtYvcVRwKAqT6H9XwsEugT6F?=
 =?us-ascii?Q?D1J+HguuOuaUHSxj6UI/LxliQ0oFOO5m6EA4Qv7YYZUO75/20OriqkCdtGCf?=
 =?us-ascii?Q?pou9B2QBbnu2krui+/T9om8wlV7TdFwFrXjr1Yld4UuAzKu0Et+/MvlDBuxG?=
 =?us-ascii?Q?QwpOjjACroYZxUHCAfLL7yxQuH8PJFvNXTYj3rYjfdu20isNMqCOqx96FoN1?=
 =?us-ascii?Q?6UNnDrwwJP+X33wD8dvbhu5PYRPZb9fm9IU8uNuLFQBn7ae70Hh3/gQkOwov?=
 =?us-ascii?Q?qiqe6LN6u3LRd0R3TqZuR7+/BqfJar7++TfEtQ5Um9wdAHc3lPF38nQMV6Jv?=
 =?us-ascii?Q?FpJs0wlLS4gcTUeCphSbio5isPOGKhTTF8K9EOc3b42rS5A3ndDBlKANVQ3C?=
 =?us-ascii?Q?pqJ7Z6+hlMqW5y/E+/7NxRRxOt0+fOA6MMLWKWqAUnQz5G2j1p77apuw7aGV?=
 =?us-ascii?Q?ghYap0d0CucO0x6GY1AUHltbMPijPGHKXD+vZz9zB1BkjCuQMBK/QtERsUew?=
 =?us-ascii?Q?gBoGgZ0cREmdYVEyTwoLgeSvBGFS1K7W5W107oJduUhjzesBjlEh3QaKY9RQ?=
 =?us-ascii?Q?4nCGr3/YmWQQQWwvBActXhv+sH/HLscrY98jIIOKwfyg9t6yFCDnV+lykx/w?=
 =?us-ascii?Q?RQqwCztKeugPISD9uXOOqK0mnFwkbiaa/qLjAHWn+YkT0gZsVS3mb3jZdHyF?=
 =?us-ascii?Q?MNFXXl6kEg9fpUbj3+zntMkvPYoUbtWLSrWZPpCpeU+unEvfkDl0M01JE4PU?=
 =?us-ascii?Q?5eCC8IxAnOx4n4Xl7JI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PP9UKvAkszKJymrBaNBerRBR3Q7OCvyjFl8KYuhDJcdP3D56ckz6FkGFYCwS?=
 =?us-ascii?Q?DCriVkT2jVPddihd7cLO2KlKS5VlForE9OyCFmhXBaWgpTX+nOvkWRDujBN3?=
 =?us-ascii?Q?/G1rl+PqZQrcz6i5l4wGe4HkvPx45fxFPFYwuD84Dmt/1r7ul3F4RkNJyDtv?=
 =?us-ascii?Q?oo1sDGITnOIYU2gaLcPmitFFCVhjPYQOdx2WDUpGQ8hwVEu9v7NDbWBE0iLn?=
 =?us-ascii?Q?o/+pa05amf4ncKeh+DYAM7lsbY8eSmjSO6RNhDoSSgs+WBF/j/MsbQcvZohc?=
 =?us-ascii?Q?LtWr4Ege3+r+Fc8NBzyZ+L1gNHh0je2qma4t0B+bBQcGnQNWF+ZJ3VE3jpOm?=
 =?us-ascii?Q?C98Flc9ml2iYldmtKxJxw3AUWRXKHbPZYCfREPhSRrteDnmEl0Japsre6sv5?=
 =?us-ascii?Q?1oWqkdC+Cj1UgFXT6JhYXoR8oo2MNEe+IHRYUzd3QCeI1Yk6BroUhSGQdtzk?=
 =?us-ascii?Q?Xi7BvIpQKK580sfaP+eeByAaz7jPPRIS5cNbF4WYC5whgjHGsOYNBC8qvRVc?=
 =?us-ascii?Q?bZoRQivNfUPSnoOvbvvsB4tD4dfnIZXyhGj4I8i2PfxHTtDfwg4qrGO29RPD?=
 =?us-ascii?Q?Q3CouD9Q3MinO1ltRYjqXmOH659m5Ywi0Cou7D8A54725YYCcvmpma5+zEQM?=
 =?us-ascii?Q?lrgEhyftuRQHZG19NwwoMp8/GJ/LCyOAF+iUiLXN5+u70VAUXWZQepEQGH6o?=
 =?us-ascii?Q?WKwJrtDW4y/NLmuqq04gdXhmpfWoAKYaJ8aG9wjaSQLwW6plZOsB6qpqIQJJ?=
 =?us-ascii?Q?4i2L8nDm0VHdAyfDvlPH0jisCHFamu2XYanQfGNF70Wlk/NIS6q3x4aFu5F8?=
 =?us-ascii?Q?F3eDtAT1kt+bsXepwymt2FGM5bepsgFp8c/TS1DhQ5PpBzZPApU0YXQk5A0Y?=
 =?us-ascii?Q?rPnSO/+tqfm9taRfQ+royudjZzwym0d3D83HXmUyMBQFXmyVin86ZQwyxj52?=
 =?us-ascii?Q?RcDnUQmpT5KAavQVfXnJJPMta5V/XmoECNhDxegU5SaECzOQGQ92wi2zGuqb?=
 =?us-ascii?Q?uB3S7HbvkYYRsnEa4rVTRHbw2L4Pq6L1f2kyrXmzDo4y30JKZQez/U2KANzX?=
 =?us-ascii?Q?UB7Eqmd0N8/aygKcN/xsD2uMZGa40lM3F8F/bhJHUTtKYPfAT3gW419ChJBp?=
 =?us-ascii?Q?KswtKSigzsjpdHU+3Gsor/jVZWGx4TG2EbeA09ucG/uzEnqucURPuUXjSw91?=
 =?us-ascii?Q?2A0LZe5HpmSCD4eDtbQIz9Nx5mzaOBR0VlgXvFOEQmmCY46Wpuq6bcPv+ym4?=
 =?us-ascii?Q?V1dfvmFhk9/3+PSncxkwy8HiwWYJqz+Mx9pmLRmxQ53j8lVCplUvmw/qTy0+?=
 =?us-ascii?Q?nJ2/qaOuhOu9S493UJX05CJa08DRdlNGQciIMmZ/akVCaWZphF6HR0TAhBCB?=
 =?us-ascii?Q?KRlvJ56ti0+ecv2lrj/3F4/uexreyitgz1sQAFr1t2qRbHq8xn8oa6gUvGcj?=
 =?us-ascii?Q?becEMouM+NLa0BIxF2ky4OZSzUvq0cgWpdqjekyTFNsCW1akYoD2+fVlPzL+?=
 =?us-ascii?Q?1fvxdoT0bmk2g2/Wh0HXF2A+ixlWTVK9RS900qQA5xzG+qWaXOzN1rNHQYp1?=
 =?us-ascii?Q?RVAjr1P8JWwKlLaZygnUtA3ZyDqOfCGYFRFGrqU+2VBYKmOScH3shhQpxnr1?=
 =?us-ascii?Q?30xj1KcltPF/z8mGMyZSBQG7o/NZq08tEOU1sevL20PRl0HmHAwmpH4SLcho?=
 =?us-ascii?Q?hkULgaAqaNS6ief2Td7NNgkrOy5BqrJWG9A0RgYI7E5i4E1Wdr49hJZnBOEy?=
 =?us-ascii?Q?btIiSPc+sAq9aXWM6qJBIZUOsfIO0yA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5wnrLfE0tqSsrTCzpNw2d7L63VEa8sQH+qnxQa+zzksfjb3fEHSXFAmhY+3XW7Ta9punIZlLgjyZVzV6OoEacHrsToqfAYo5o92g2bjsSpl5Tt56vfrwNxPw6CfNOZQRxdcq/enwpPO7/9Cajp34mXHg5bQ07WhacmUxr9b2XzmX5c9io2C600j18IsJaYQIHRZIOVrN66PlmTSpRLOt6aVv45cRqxONNQ/mnVSNKLatCiRUDvCftkOUNkRX4ypuvJ2reSTa/te6lKajTcUiS6yzYetbtKW3PuVYweBSmQQWlgmPAENmxLgYdY6TiPf04tu1yOqgeS8pOdCz3yOZCp75F2Z2eSLzRgnrUDMaiP9NDPOqI0NR03TkcKAVlTxbu4Ej9NkCW/eNXD5Uo8pX2LUNuUnjZoj9q2f1aXlKsa54S86dNJbO/SyHGP7sj7P7zpjMjKet3AvkoCYlMPQZ36K3Wnnhhsu5XXpqMSL8fR9g0MYmBRhIWWF8bN0Ns6AW0CpR7NcHTfQkyFwSvoDGilAh8I0Qb1DHCxAGvcw7Jzfw7TPsgFajIeBOipDIotN+x2FB53c0CcQ2Ku7rqGDRj+qkr3XtwWK6v7ca9sMbQa8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8948aa5-1f45-40c8-b316-08de5a919826
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 15:10:50.3462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLWG63A4tnmKtbqhw7qd0G/e41laOgp/kO/LLT/DhqSS2OzP8/ZHotrhuPTT1YC1CxjFsbmhGQDVwQtZfD4usKqmGsoQazFGfiwkwVjT6bA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=948 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601230118
X-Proofpoint-ORIG-GUID: 7o7a95B0wI9J2NPM7l7DdX7KZi7k9Tmb
X-Authority-Analysis: v=2.4 cv=IsYTsb/g c=1 sm=1 tr=0 ts=69738f7f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Y5KXyoYS3OwNQl5rAXUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDExOCBTYWx0ZWRfX3rQB0+AiG6UI
 OD7KGorlb6ZHPZKutb0R7hma3mgqjpKEiEHtCpbpMdIAlMr1crtVj21RfNYnrfT+Sxmnw6zlb29
 MnVzUmXKSbiKOrraZSOwA48J7XyiUkRIf/DAb6TXXjk5dicp4/KD6OU4ThuvZ1qRENfCqxOWmZe
 FYp3Fe/mkfnRzwoc2DITw/QFfZiuUA/nfg/ftL+Bg/xu6w/Hx8gK3X6NCF7FIYEkxPWwyAmi0HX
 SULmXhPcAWabAVjCdGyUXRxhPR+DO+pAQnX1oRPJrnLZD1l/HK2bYhQsOm5P/8RZTgx/Ox86E3A
 wiTyoXPPLbDk21TKy+vXXmoeMZWsWUGoC261GJRTh/U344dM4Io4z0sCmEXwzH2cNkdcqaA/Dhu
 B9w8zrMziJUn4UC49fy2VdOz5Pa+iLp0H1qjjLg7hyqj3o9yzXQEgjWdGMgkJa4LBA7Ku/l16sf
 8WEQx3Bqexe1UG+toOA==
X-Proofpoint-GUID: 7o7a95B0wI9J2NPM7l7DdX7KZi7k9Tmb

On Fri, Jan 23, 2026 at 09:54:48AM +0100, Vlastimil Babka wrote:
> On 1/22/26 14:01, Lorenzo Stoakes wrote:
> > We're doing precisely the same thing that __vma_exit_locked() does, so
> > de-duplicate this code and keep the refcount primitive in one place.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

Thanks!
