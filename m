Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3973C2E62DC
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086282; cv=fail; b=NlRTIQNXzgUucZ1ZzbGPYPALY6W81M8buN9KBIpJ+Ftch6PQLqhyt4r1lV9ljEdueg4j8wp7oMSreNAkntFFtbz1gRvHSBps2ttsa1ZVBLTaq9bp9GjmzMwgK7EVaqppbS/RucDN5Xr2t+tgzLPl2rHmMKL7D6StU/zR2F6hj5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086282; c=relaxed/simple;
	bh=PmlPoYN9UMPoqUaYe1UaZw/5tjZmNQlG9mi09/kQKwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YEQciNQmRwbi14uTq1IWkeXfS72Y0+U7KCAxLqen+YL1ya2zWl5IT3jWNG4oENVBeWVAwEqM+y6tATG9W5M15mqZKM7vepIO5mxGhYxV8+xM0qA57pyv9/DUC582xZKpAbo8Poubis6pXjkgO9K8U3ROdebeYBNx+/sMCGOKgXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O/27RYaI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f4O2trni; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O/27RYaI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f4O2trni"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60LLsXc03867763;
	Thu, 22 Jan 2026 12:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7I2rkw6x9wHeSVKa6Y/4gBkHuoXDeJ2QiF5/LB6Mcr8=; b=
	O/27RYaIs2qEDPkoZjg46pEWLU0OVMyunyCAGNs/7MmS6CU5q3BEivXAJOFwe6qV
	hS4T0KDwokkpLiSwSblBFq3he/wdjKrIhFvJINtzdTbqgh2IeCslm9cZNhoRoMFE
	tGe4JqTY9F399AdHckDS1s2drtXhqEfpzMEv6EeTPJxP3DQu7PvSen55DjRcYX37
	u7uFpB675jkXlEdm816x4Oak03KcGtJZG0OR3IpQ6F6QZO9cpKfwcVCwnKK3acjj
	PPj9lEhtAtyAYNVTfWFLHC51Gv86YvFQCGZHyJtWXWWUITRS2Hm8uufbui8Tmf5o
	ZJbuymbE+ELLgdA+FaUgHA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagd469v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 12:50:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MBBvjB008413;
	Thu, 22 Jan 2026 12:50:53 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vcsyvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 12:50:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jg+kQ8yul8N0JF5cCTQvZTogeiM33wPp+ka/TAoamkHVdvXq3P3bUUPg4k8nXFyVnAwuC7buwg3Mn3RUM/4wbXBN2PRfP2Gk3B42/w1xaN1IFAE0DqhgkFpRJhUt1vm02k7HqR3zOQ8cY6sYwE3wyKNBl2MRQyQ3L44fCGA4G+clFJ2bUsCLct428oqccmIEKUcWC3/qhw33Su2wuK2KyckCYokRYXdCh1pKcto/gDCIOx22zJSdRF5FMkWkh2ABt8IxOzd4cBoCC2jiFUTyYF8ypHNWdlfWzZ2nGt50Nhb8m1YvYyTikpXfPhk3h54eIGnAuODCrlS3CjBmnJhFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7I2rkw6x9wHeSVKa6Y/4gBkHuoXDeJ2QiF5/LB6Mcr8=;
 b=AqbTpwKtK8qXMTBadAo+tasLYaCPbdXhIqWjEQXceYhquS1Vpekb8afjS+Eo2tNe+6QN6OpeqyLwryPj68Egp8fSQDgOwz4+l4IT+MBYvKwzlYmrNuJ6jq7y/4NqXyO/XV91HVOurUDuVPIIX4E3U5dr8a6L/twaRpNb2iq0M1Wk87tU+uajgAS9LEAK14IvhT4QZjT35PeEiO+CXUikFR8MX3hh+tGMmyhxMAriqWSUNPD70UZQIE9V8JNu8Xzs8QisrO8Y2v8okEn7oh+xergfgBUclSwa31lgjnCOEJ/GRPDZRLmfc6ung88am2Xqkbx6olr4eDs8yWi1EKt4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I2rkw6x9wHeSVKa6Y/4gBkHuoXDeJ2QiF5/LB6Mcr8=;
 b=f4O2trniyRpVYFmn/HVmc+/mvVRirX4fQ0LHjTcJsPvlXXaOVqbFe9tY8uFagh+18ypo9NgSxXV26P2mc4uo3IRRrRKP4XYWHIZcmmaiSGac5wI9F0c3GahS2uD2siLqjm121cXBWg8+YVVBflXUXWzrfEFf9NH4ctuQIl2g/jY=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS0PR10MB7904.namprd10.prod.outlook.com (2603:10b6:8:1b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 12:50:49 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 12:50:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 09/10] mm/vma: update vma_assert_locked() to use lockdep
Date: Thu, 22 Jan 2026 12:50:29 +0000
Message-ID: <978c21c007cea57d6a6724cb4028ab52ed7b967d.1769083595.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769083595.git.lorenzo.stoakes@oracle.com>
References: <cover.1769083595.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0243.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::7) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS0PR10MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: b7305ab3-ead0-4680-005a-08de59b4de94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wYhL7KC6J3S9tTSXQwpI3YmAaBdky5TxKiewzy5zkgJij51swmlfTJkDu+nk?=
 =?us-ascii?Q?PSvMvGeBLlxI4mq0E729ihk8GbmP9+Ghq4i5TG+fYaKKNq5t8NbMDajuTJQ+?=
 =?us-ascii?Q?0fKEgc1H+epDJOItIubX6+YTbh27J+GnSB6089mRKCKJxxwH3UCP+HM+GGPJ?=
 =?us-ascii?Q?Y+W+DtODVXPN/chXJ/MOY4f9Ap7OuUyxBkYePn6ZkD4hGd8tsfuIgRQeeCFZ?=
 =?us-ascii?Q?CcPhz1nnPo7/2EL/fVtmXXpAl4+1Q64/oGIabIuTr4SMaYfE5FhWGlFCJC51?=
 =?us-ascii?Q?tAMHRpwxD+FugW/LR0ex0dDefLFPR+CQdlNsigHooPPGufHRH7wWPCUMjjIU?=
 =?us-ascii?Q?IrGdCvW0mgInGO+S+/pWZGDlXZjBiSLmLTeKHx2qLVqWqm1urAToRSIPuUOs?=
 =?us-ascii?Q?QkIByujMzgYQ0ro0EF5ORzEkyErueuwG+ysiJNIfyjKEVi7NR2muZ5McK86V?=
 =?us-ascii?Q?ISuhOzBSfW+HSfNE18CMeaSCclMZnDVQ1dsDJhvgxUYp+EYBo7BD7qLVkQFq?=
 =?us-ascii?Q?LyNhuxblvZUYt/EoGCSpaSenbgGC4OMv1VYzYwSVfbqZaAofns3uuZ+NJ8xC?=
 =?us-ascii?Q?xMj6+kgg1z0hkVM5ZFdEAI1OjE2strHtKps3uiE2fdVud7s1ZrGG/UTgwp9M?=
 =?us-ascii?Q?iuQ8YaJMbZkYqJ2Ok4fkkV6fLB/Jd1S8Hy/gkW2a3cTqszf7YmyvV87E8x4W?=
 =?us-ascii?Q?4IoQgAu9x1rxF4tcDTmagfY5n9gYRO3HRrq/vl79AGbV6CK0eIlECCYOTEdN?=
 =?us-ascii?Q?R1GY+LI1a0KZqzubmRNYWBeQ4q6r7qg4wgdfNiZ9K1tgFZ06lQqThqHvjAdp?=
 =?us-ascii?Q?gA85t+UoY9Nceiw+1DWnk6pnK7qJTruzCIL5f/gtUEnigaQkGKvgtxw75vVA?=
 =?us-ascii?Q?w2w+nO4hIN1hP9k9P9V1ZaZvxkVKOpDVyoIFCtcEwW4xWmbVFyNCJKIL7MdE?=
 =?us-ascii?Q?pUF30s47+z9jfr/mGzlz11V6Y29Iw7hwEXBWxHCHyIoiOkaMWjlllBhh8zCZ?=
 =?us-ascii?Q?w7+ErCsVAO32hiij+jXWc1fMDQXh3gHJueq7jxdf5EC85OGaUsKRpTGOp58j?=
 =?us-ascii?Q?nacWt0CDfXD7iUzzn+x7QP/xe7ZGYVtk2M9K2wPIaY+Lt364BWMXpFDI+fMt?=
 =?us-ascii?Q?DaCi0wFYZsjUZCiBM6XgiExrEfZLmw6ogVzKbs5QBzmWoWVeUZVRteMrJswn?=
 =?us-ascii?Q?AXaEJnnYyt9SrvmoEdQ6mvFrtYTuN9WOR+OG3WDchzG5N9n37Teuh2eHfhIY?=
 =?us-ascii?Q?J5TvGSokb0VUbLT0ugQXrxtO0wOZSNsxnJQD8MwXh3pDPRLHGXc4bHM1O5hj?=
 =?us-ascii?Q?rEiyEneKNWb+MZAGZ+kflzrAAoNY8zHzMTLg9KXqbbpf3iPwqg9wbtIbgW7j?=
 =?us-ascii?Q?a2xE1ir5i58sbV/yU527+/uQXNc7IyIshJFAfkodbfcgwJFPxet/mgtZN3EV?=
 =?us-ascii?Q?cCanN/ei8Z5UCz3ycz440CxOWsRNwprQ+bSLs7yeTqavvtBpX5AgauuGzDhi?=
 =?us-ascii?Q?QB3dcF5rP3cRU0fUOmw2yujDsLK4l3vf9nObAgqxm9FJDh5RUTKAMtqBWrhp?=
 =?us-ascii?Q?cf785tzBtILBJQANp0U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QW47mO6vUsFD8Emu8UdkJnd9/yo6iHA+4ZG6H+NwoC5/qB1gZXlbelV9gE85?=
 =?us-ascii?Q?hjmyUPVqSZEVQ6VfAYUzDVWIYyrA8Morfd2ZP1QmlaET9n5PKMCy5bbF5ipc?=
 =?us-ascii?Q?JRAEqeq5I03AP1LB+f1TsYtp41h0SSGw0UjwO7dLPhCgH/VJXkryMflzii6E?=
 =?us-ascii?Q?o+EaPBghrgk2ElGpLnpDd+bZX7JE1PJyXbzfqPYuKCpFWuDypcFwPN3ORLPc?=
 =?us-ascii?Q?HG+PyxgCckCIaxYrn5jqXQKbRKRwEQAFNqLmDS85icVTxc0uLv60UadWTwS8?=
 =?us-ascii?Q?ISBwwHIYfkIpkkxg5nrqY8DPgLFdchr825mzMGR1PUj6QxPjzndw91cxM3WH?=
 =?us-ascii?Q?+EVEAhr0Pk4PAVuZEAnBvDOfpj9Lh/Lc/8vLYrHEKHAFcqLsksMi1wBHkpXI?=
 =?us-ascii?Q?umD9AnrghyIgmPYFWH4qAmW6aJmz4TVtF02CXG2Dzz3Im+PrN6aAtmfs0n+X?=
 =?us-ascii?Q?HxByp3ZnPc5rKk8UZFt0CC4tOy6bQZV7/yWY6yZ0v5pgVVUfWvXWguY7v/8M?=
 =?us-ascii?Q?IzcXXGXKzx37iQ9zoN+mtuL2WxxIzMQ8Mp8NwSzzQzF7spKzDlsdxb9lzw1H?=
 =?us-ascii?Q?pKGwyW8elr+K3dlx9KdJ/Y1x2TrkLd3yUdOkNDnb5zexvg/1+6ovS3fDYaG2?=
 =?us-ascii?Q?WlzF8wj5NoshjG954XDKAI/ap8fnR0fRHDUJ/odhvkjwd0Onf9fMuAaO/GcM?=
 =?us-ascii?Q?6h7hkpUG6jV0D5u1sUrv8730YZsG0FzVaCli16RXGhWC1JkDWvCfXArBUOP7?=
 =?us-ascii?Q?//sAwaMbJ3ENZ0MEmT6THm2Rqqsm6SUtNpFuZNAlycbN6EyP3dExx8Ub6SuQ?=
 =?us-ascii?Q?wPzrDTW7YbXEbvFKjB8Oxnk826QlT7C6CBq6xGMmKHIWBIPd7PXU2kN/sv4g?=
 =?us-ascii?Q?TtyBDy82FOwYX9VNPjTgmpjfbDMbNAdgLlgaEAelesuS6Oq5g6EukLX31xIx?=
 =?us-ascii?Q?ATcYArQEEJOqArcD/hQvDhKtpJSspCBeARiRWKkpVVS6XRM8OaXXLYpVX59i?=
 =?us-ascii?Q?ZHMFVdCT+67pk5QODhPb6HUXk/HJYP3GJa4EiyOPNfj9RbAQ6DQGJODXkJd3?=
 =?us-ascii?Q?pCEZmYz8/28P5pcGyhoe1Q07/x5hmWywegJZF43slnswFnPAf0Wedlu1pLNP?=
 =?us-ascii?Q?GlXrMLqpfXo2sNk4LkTVy08Qvu59XEhcz7dogh4yj3lCbT5OWiFYhwXMVNtS?=
 =?us-ascii?Q?7hgsA5WDHv018Ig4m+ncCnxoRn7dc/zVbz1eaz1WtCGUl+SgGh11E5GKVU7L?=
 =?us-ascii?Q?TIDr9u6wUnkXzqvI2BQ6Bj/QU9frycw4H26aD4aY/YFojA6/79ifwbes3Rzs?=
 =?us-ascii?Q?HMAmIovz3x01G3BYEX0EbTME5/OZo4vSs8yUHcigAecjvrBl3+Vxt2sFGaru?=
 =?us-ascii?Q?N6fXpsxxc6otak91KXM5g6bSJnyuuUhvq0N3PtlI5vYXkv1mvr3jhmDk3qtn?=
 =?us-ascii?Q?/6zAClZfbFsi4T94qABzsYVc5Y9Inlc/J1AQ3wWavng9447tWQqAiS/YKXxt?=
 =?us-ascii?Q?+1589vMiiZqusVjdX6MTJfCm4T0sFSkhwwsnall5SFvoSl4khOwwz79F7IeJ?=
 =?us-ascii?Q?5EN8ZLSjr8cFHfedO81vDH8l4qFlSp1SSKMJ91YYi/2YSBlCbm8qFiVnTZyb?=
 =?us-ascii?Q?J/vZmFXpOJ2vUJpQnMP4Oge05tyknAk4olVl3/teXo5WxL0uRai/MfEPwyoD?=
 =?us-ascii?Q?BSZ79UPYg4jeaxklNDmcLLl63ZK7CJWzVUH7XXUe5aoAu9ExEjG3afQ3fvrH?=
 =?us-ascii?Q?1bhEf6Qo2Wh7CfakKE94SxI+0qQCBgg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M2t5phZD1jBGjEigcirDmMtCRPTVI5/UYO9a6NPY2nOEayMQtDqnIAd5gB5MAu+wQsJuEblzPoS/7sQmhcv76F1aj/c7VSvv0OFryBSk/ctNkvmXKO8Er7IfsuZrXnmHR7/QGSCpAILqQfzTywKXO+mYpVthfpzWy+Hi2EUdNmpEivwoWYimBuRm5xJFC5fdyemZQouGl0nhoauCYYpfplVm+bWv1DM8tLfOK+GpcpOD2dmbx9AOWTsn0aeS5zsT42zU+8VxdFw1ex1l/J2jRWxmnZ+xF2O9iJaWACoXZX/hdBEkEzryGRcizpqvmvS6fX+xE0fRU8lrJcKUjG5/yKWdFJwJHKOOGbKMeJjIDnG76fVabs0GtaHAYpfrnQqjcZR6XbEUw6FeWDfXlqADC5kYgyw72vDBA69kV6S9L25ls0XdbAg9eWTBYwlhMUsg5iluyTihnz44mT1ctB2MgyBN6XMP3rIinIGp8fhYfG9SBIg5bQHh8/0+NCBQBsAOEDlkk4ncv7TSHqtYTuVTrWuJDyffF/lCxOI0Ey4G4Yh8uyoy0kSMYqSLWcMgGIWB1ycYGQsdn/NL4yQI+waCRj5qurYQp8v985C2z9GRxLM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7305ab3-ead0-4680-005a-08de59b4de94
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:50:49.7008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ya8YuXgSxraylTTVRzjmhA3tNSowZVkkjQbtDjBHXKPMPhA+shtXyqlIMBKYunkHrHzWaOnphC91apZ9vJwTf0Z6ZLYvJzsPQGsYCYgIiDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220095
X-Authority-Analysis: v=2.4 cv=PqqergM3 c=1 sm=1 tr=0 ts=69721d2e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=UGbfwpFX44Y6iY_wFi8A:9
X-Proofpoint-ORIG-GUID: 5EssrEgLrx8bfx8b_Ot67d-OiTM8LOyO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA5NiBTYWx0ZWRfX4icj/WmMwvg7
 DVEI6EUsqPhWhc1ZDx7Idrd+CBTGAPMKqFQOWPy/wL8jgmoc3k/hsK/grXzdc8uapjoGKNDOkfJ
 ykhedrS6lXQLtQns/49YsLpDbZQwOYfQ0uCgp4akchJ1LqHawnYtQsM3xIvHs0qYEtW8fZ0Fagg
 tLz81SHfuMTwbXtpYLehXlgjllEK0H+1DGqbxNXeWKXtSv4ge3m8bTB26Ureb+7TsWFkusSIo6B
 OllWCtb2Z4oIfWQjG+uY4hJJoGBsbIxROK43x2iKDN6SrBUfquJLK40KTPZxBvrgiOUh8h3h4KO
 2l+31l3UxaWlVDukEre9YuRscYHnbdiv37OikKvxJExAVGgDpDORQaLRtGmBi+ssHO1Ok39Bc2P
 RqFt+PMwY/2/Eumcj3jw9+CY5+EY4MU2hrP+aU2Oj74N6+2GYm1/zT5k28ZPXgrrKTRocgpdhmu
 xwnbLKDOhxBwFRf707g==
X-Proofpoint-GUID: 5EssrEgLrx8bfx8b_Ot67d-OiTM8LOyO

We can use lockdep to avoid unnecessary work here, otherwise update the
code to logically evaluate all pertinent cases and share code with
vma_assert_write_locked().

Make it clear here that we treat the VMA being detached at this point as a
bug, this was only implicit before.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mmap_lock.h | 40 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index b00d34b5ad10..f7de79703d84 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -319,6 +319,10 @@ int vma_start_write_killable(struct vm_area_struct *vma)
 	return __vma_start_write(vma, mm_lock_seq, TASK_KILLABLE);
 }
 
+/**
+ * vma_assert_write_locked() - assert that @vma holds a VMA write lock.
+ * @vma: The VMA to assert.
+ */
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
 	unsigned int mm_lock_seq;
@@ -326,16 +330,46 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 	VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
 }
 
+/**
+ * vma_assert_locked() - assert that @vma holds either a VMA read or a VMA write
+ * lock and is not detached.
+ * @vma: The VMA to assert.
+ */
 static inline void vma_assert_locked(struct vm_area_struct *vma)
 {
-	unsigned int mm_lock_seq;
+	unsigned int refs;
 
 	/*
 	 * See the comment describing the vm_area_struct->vm_refcnt field for
 	 * details of possible refcnt values.
 	 */
-	VM_BUG_ON_VMA(refcount_read(&vma->vm_refcnt) <= 1 &&
-		      !__is_vma_write_locked(vma, &mm_lock_seq), vma);
+
+	/*
+	 * If read-locked or currently excluding readers, then the VMA is
+	 * locked.
+	 */
+	if (lock_is_held(&vma->vmlock_dep_map))
+		return;
+
+	refs = refcount_read(&vma->vm_refcnt);
+
+	/*
+	 * In this case we're either read-locked, write-locked with temporary
+	 * readers, or in the midst of excluding readers, all of which means
+	 * we're locked.
+	 */
+	if (refs > 1)
+		return;
+
+	/* It is a bug for the VMA to be detached here. */
+	VM_BUG_ON_VMA(!refs, vma);
+
+	/*
+	 * OK, the VMA has a reference count of 1 which means it is either
+	 * unlocked and attached or write-locked, so assert that it is
+	 * write-locked.
+	 */
+	vma_assert_write_locked(vma);
 }
 
 static inline bool vma_is_attached(struct vm_area_struct *vma)
-- 
2.52.0

