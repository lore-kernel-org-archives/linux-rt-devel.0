Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2A42D73BD
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086978; cv=fail; b=ir5HXf/kMprEAHjnRQMZ0gLs6OCUwAnbNn96P+dSmlf/+L5gwAKvz09r2gGHLA2bsTAX3msMg5q5gfprhwzpNYc6joeZ9NfXJitW1xAZ2Su58CwMY6dXW6/8RlKi1muFm3xLym4ThkSiaFlUT+cGv3Lv+DrCsR2vSMHTiTu+sQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086978; c=relaxed/simple;
	bh=u8iWFP+GDZqdY0Z/E3E8SJAGg0fNWfr2rEa4xDRCsd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kbFLMEb4h0E9F+1zLuwWhgICWnXsnsh7LhYSOlZim405VdsKRPuR8VdCwXFWXBfxyjvqA/rANJs+9VuhKL0XNRaz6YhDBKBBjUaXzgr6Uw/bcWqENZ524d1rg6XV1I3NlBKg3eAQqIcz/PcxoC8saEJAZSXOqqVTp/yElgQ6R1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fiJvFbna; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fOz66gCe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fiJvFbna";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fOz66gCe"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M3XOln3429768;
	Thu, 22 Jan 2026 13:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vZPx9Cgo+BtdSemhmhSnZT+VNAK0JN8lcdGWba89ZXU=; b=
	fiJvFbna4ME4GMJtjEX8g+hmnrI5XdPbuxTK23XMsWlC2myBb/5p3bGvD1zz1BNG
	ouvWJ8jdgsDpXPLEKyKq6ESu+hXf+/ULM/pTfUgYLL3/w3qIZY9xXFBNjorgbN0u
	lsHs8gADoEL/la36QKBQAGCRd94o+cKrHq0LzjGwvd6VFM5I7Aa2ZMpugOhMTJ2x
	lFE0NU8Xqi+hEW/nXyBm3Piakqy/LF+s5iJn/ZR/SkJTvb0RQ7mQhvANE0QOldAi
	3kh2oT91nb8OcDak0v+Lv/qhsucS6TKMdvd5r7HRPEOnQ5Rf/M8pTZDVfQZnHWG7
	13ScM46SyzYQLXEpldbMMQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2a5qk8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 13:02:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60MCejMH022456;
	Thu, 22 Jan 2026 13:02:20 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vgjp38-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 13:02:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eik69Z289R/0zyAg76k4YVilQ2wV9Ted6DjVWNN9h5FgGZnuNHMqKSlKzR/GnU8QPuxv4x7fib+XRReHtzmH+PinCv9PLpuKGJYIqGHRB+81BxRPISlmF+rLXZVDYW4PcULlX+/LE1nqZvCMFTjB8kQvtv0Lwf7IDsOIrJxegwa0M/8yUeBfg6qVuBM/EpwNoAqiphUkvC71XJErDZIOnWBUkzEIhR0fRdYPXFysJP4miMjx/rdyti69r7z8Ny0hZ976kXEz8wsGQxLAGxoSHWKoAWZXfAs+ugzKjqDtO09ZpnepmRCcYjtdX8iAhok+xDTB0mbsKYcaT8AB8V80NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZPx9Cgo+BtdSemhmhSnZT+VNAK0JN8lcdGWba89ZXU=;
 b=b1Xuk9O/AWdRZYS9vYcMfdG2wu5R6YRbqUnbPIav6ZCJjOlQxfeAShr4kvS8MzinYXq/qd5WjqCppopCsZ8wyQ/2Eg98VWJEySNS+wuKZ/U6wQr497ImnaOFdHR5pXrRNDQGXl0i8jWhBRbtzkYrcGmgvfZpQ3rPIF69MdY4iv7tngAK9oVadHhWzX98f5JFsleLuqModEO5BBFC9iyQvfXCpBWGANPCwhNYOn7gH5Tgz8DQSwhRSospC1xeIykSdeiVe9P0g2RY+ISjRsjzmnXNfUPsK95hShqtsL6nT9k1OeMmeU2cv3CmY40J7X5CEcCHqwWCMFWEiboeRl8MCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZPx9Cgo+BtdSemhmhSnZT+VNAK0JN8lcdGWba89ZXU=;
 b=fOz66gCeK0OP2WeOpG88UoSKiTWJFBr4BVbLWzaXG6278p5EdXfoWr/b1bYNRJr5v4mBiVyFCfTYt2Qef9YEqvX3G+DgdHgIm5migDGLZscTHW6EveyDZu/V3jK0KoWrINNJUrpUP5RUpZ+nERz1H0bjY3qK2pW06zfTvUx3vi0=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DS0PR10MB8198.namprd10.prod.outlook.com (2603:10b6:8:1f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 13:02:17 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Thu, 22 Jan 2026
 13:02:17 +0000
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
Subject: [PATCH RESEND v3 08/10] mm/vma: improve and document __is_vma_write_locked()
Date: Thu, 22 Jan 2026 13:02:00 +0000
Message-ID: <70dcf80f79ecd00a750ea17101061b0949119429.1769086312.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
References: <cover.1769086312.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0231.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::17) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DS0PR10MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8229e0-2abd-4c29-bbba-08de59b678c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WA4DcO50WUK4sMKSyhmazKjcLZM1zEkvUonVSNEzMjETcyFQbY7sWdNyc359?=
 =?us-ascii?Q?+B3yBmJZfMgQpjXhZ/zRMHHx0+0tx1cSsm1YORCcC+bzhvuCyUN8XAs2XYDf?=
 =?us-ascii?Q?p6hF1DqYixeknVBxnQUJQK/LYzbIsms5+XHR/HQYKBDEZT1PbfoYUtnRkVSt?=
 =?us-ascii?Q?+YcT7Cv/GROVShp1R9ytV0eSQwbXuXSPDk+6F4qQntoFbElMFjryQcY2dflc?=
 =?us-ascii?Q?gYpor5AnnyCBn2IVhEsv/USqHZkIqVfSkcoydBjk8g2D+tkOiF8pv2+Az0Ru?=
 =?us-ascii?Q?5k1VUXa9W+SHyQFg3o8OUV8U8kLh4xUwJ0fs5luwVxkJxh7QaVcAsMXEb0Cf?=
 =?us-ascii?Q?rp6ddTCXvvmJt22+KGeeGw9cRa+NGl4QtOwultf03GeLrq7ifOX8LzvzloDb?=
 =?us-ascii?Q?eb7kDJEdSjoKa8zSJzyVnfXC+uocBltNNuijjEw71bOmLDqPZb7hMIk/5EGs?=
 =?us-ascii?Q?yR0z0KOFg7z7ZEw1jQzLtMi9nphyyvM26sREeTKhlIxubQEpaYFr6vFfHPoj?=
 =?us-ascii?Q?VYklrRdEOW2EtkOkTUd1vVeO1nWUZlqxDwA0L68E4In7je3kPFjTkQ+T8H67?=
 =?us-ascii?Q?bKvLkWL9/W6dLbOe5vux1uluoyB1CL4yTKwet4Wg8ppDnMkbM3ZYQ1bFAglj?=
 =?us-ascii?Q?xnMGHEXY8Hyzlix3oVUt+iAgEv/Tijzd7PJX0+mVY2n4UPB7XM7iAJhPfRmE?=
 =?us-ascii?Q?ng/BWcHV0aosVzGlyJJZhqxo/Mc5VycH1yHwkeC0WNw3zOb066F52zqMVsr1?=
 =?us-ascii?Q?mz1gGuplh7vXt+YnukfYV+5rnXrSTHG2T+NzkEYA8GXVS8Bbzvl4BmMCgP+2?=
 =?us-ascii?Q?d3oAB07BwIfJeUEPZpOZgBmIRbBwynqDgXM5JqJ+uogUtpcjmm1eUL5duDIm?=
 =?us-ascii?Q?1Swis2D/KStMvGFGiHPU1Gbe8/RCSW00mr8rsYcUD6l+JMdYj7PyM3QB9Fvq?=
 =?us-ascii?Q?AJeN10o/kjJkL16amt6nljy04KG93RbMKgesN5B3VZZvHcmeWoIU3O/urO82?=
 =?us-ascii?Q?NjoIRzhZCANplq+vh4wheGx43PqpPq9BeLi/jPral//vpki/6atGH81Cd4ms?=
 =?us-ascii?Q?mX9ZbQ/c918Ut7d+PRbDgZD05i35qdEiurzDVWQ9bDwhVFGgzmfGIMGgQf0N?=
 =?us-ascii?Q?oDYG5GPVP2MTfXbWhRBuoY3TrIG8N6nj3YridSoVxy+cubH3eAF8G6HQbGY3?=
 =?us-ascii?Q?uxEtttu8xQ+00xjWdo5NrtAZKxaG3vRoF0l5kmTDT9hl9448jL9ah89iyl08?=
 =?us-ascii?Q?1ShHYn60p0i7mrSstyrX4tcTcpduWF1SeTnyOBiRFwgOGRNnMJ1c1lsKQSHM?=
 =?us-ascii?Q?ZfGuqt3HajRHvi3YsOvBcLIPPPqAZxd+gHFshpcIccqBBBYDatGLjIPXQFsQ?=
 =?us-ascii?Q?LCplRsEKBDxgKMs+KmC1E3AMJ/C5xSpw+iS3+mraU2jgzraDKfw91ka7Jimv?=
 =?us-ascii?Q?O3iPnf2OCYdPhLsXeB1zV8jH6/VkG9hQKfqulrNZhalAMlvUvsdcvzEKT0UT?=
 =?us-ascii?Q?58P+wx6F4anIijrsGF3V0OSeDoOUvbJjyVIS2s+2bwMk1vZh62DSFAhpSJbm?=
 =?us-ascii?Q?A1Tr7NeXNfw1zPi4b3E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4XTNYNlhmlmXdjcnPZE/v2B76qqow7IQ5FpbGZKBy1+lsxiJSxOyFj1qGm5e?=
 =?us-ascii?Q?T5v4lNWi+kSwO9hd/wySQ3uqF3TRO/5oQ915g30kT/0lD9l1jxkuAH2XtPZq?=
 =?us-ascii?Q?uMRCWTKu0ODui7EndwIOM7zovadx2tg9cXBlnw+AspF8nlbceCPKS/inO6cT?=
 =?us-ascii?Q?VwWM0gzQpm5nIGn9VaAvXpD5EBzEodT74t19i2pB5s4aAVNPT7pyLtHFDmeA?=
 =?us-ascii?Q?9xmUKhVtKl6c9a4ezZdEKc9eT8mQ38WJecBCRZRsn1xgsnNGSpiQ/41yDiu7?=
 =?us-ascii?Q?H1mEf7Uy5TCwnVFjJ/MjuRkzAW9VwMsaTXTMiXhpZQ6aY8HW4crNG7njQEmS?=
 =?us-ascii?Q?bCv5De9aTqSIMmHvqY4E3GVhcj7+XluxRCCmwx57ilTCNtg6FyYW7B+qPq7R?=
 =?us-ascii?Q?EXo5OFU5IimlMPUhh++5eyWLEGBhoXf6Dn6bSWi4tTYt/Kpz5/x3Gg58JnT1?=
 =?us-ascii?Q?7pd+JdC4kLZwL9ZqpBiXxTK+9thWJAAFjB6KV12cmck4735A1+1zpEBdtqSA?=
 =?us-ascii?Q?WCItLlmfohO02WOKllQJmm5CwhE3r05A5M70hirBP2jGK2HEWZC18DgMVMgs?=
 =?us-ascii?Q?KoTCiIHf/ltln9nIjJpI9UJZGlJWiYcCXFZ9DamG/CULjvRUMlBVwkt906U/?=
 =?us-ascii?Q?9TjnGSQ2/Otb5YIjXuxZQ0nKPt/5Kk+lDjoLIvxS8T1ykRFpXQrHi8ODFWR3?=
 =?us-ascii?Q?XwxO++LkcgiPB9nUNXrLFhqE/tq2GSQY8yt7RQ7eyQnlnb1eYHNCCTeOs/32?=
 =?us-ascii?Q?0+SvP59mBBcAv7++apdvIrkAtIKISTuObuLFm7ICHqge5B5ks2QEYt2C3Flt?=
 =?us-ascii?Q?5Dvahxd0mU1WA3M6G8ISkStVLsy/qYmkwLTarXRJ7WhfCluQbhVkUezvziZx?=
 =?us-ascii?Q?2fdf8+qaslP+BbI+/+gN/xCu2UeN+QOThhHe6pWXCFJRRt6aFPdu5+Ascrj7?=
 =?us-ascii?Q?aCNM9J4NAHiNMxBwHXalnYPOCIFYJEiIVvRk4VIji6BHBmovaRGhyQIc3lBE?=
 =?us-ascii?Q?J5tPfSdUtugV7m9FEDTA4ZeSsi6qIjSVK+i/e/GX94X6dtCj/X1FCV8k2sIy?=
 =?us-ascii?Q?pd4wG4klOG+DiJQMFXoLNRKHPEALwWiA908H0BdX10yM9BGBoELydsU7f+zk?=
 =?us-ascii?Q?ucWyIdvsIAHohfyC7or3Co6+8nMcw2XxjUjBzYg0QaQpFrVaGXHPO48pN7EN?=
 =?us-ascii?Q?8mo1YdW+LSB5DNWO6fp7AYExG9u1TwTA3b9wLsEGYpRgIH8p2i0NKF3lQW00?=
 =?us-ascii?Q?43Qi1etu+x4ySBZheRxwRxVFR1pII2S/41AbHzzkTVE0Nlxtf221rGgpWriY?=
 =?us-ascii?Q?fYj/K0rTcKN3Z+kdSsGnw2jbBXSHkIGV8lbd/lOOdOlBpvu+/R2LZq0rE9YY?=
 =?us-ascii?Q?CMothks7wprX/JRg/lRDVVjvze+oAECL6cifluC3sONbZJs27+8CTvzCWuBi?=
 =?us-ascii?Q?YS1kHOdxMH1lXzXVgdx3q4+LU6HKFGFTSPinU0M4jWuVkJkmrs0b8nJ1xNSy?=
 =?us-ascii?Q?FU36gclBSBsPMPVg6epFabE3SGuaDbDBpXeJQy4/mTPC9+7PXDOGyKoVXGti?=
 =?us-ascii?Q?8erEkfCdG6ehIppxwH5LuQrN7gQ5VqoP1qvBZrFGSfsH0j0qMYeOiv+oteUD?=
 =?us-ascii?Q?vlo1B/HVm4wXKRV+UP9MoX1EikZbkBJ1OVEmYav0PTo3MfhwZUNF4pLmIJsS?=
 =?us-ascii?Q?8TrRcjROGhcrilcQ2KGMm8p2xPpUim8bTIkPbgJIvZwRr4IhdGmuYFzlWCqj?=
 =?us-ascii?Q?lQrxKCx1UWefyOjUoqDAMXaE/Ab2kkk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j0MMgxgvAwPH2jOkUkOqx8zw6zjpnkz8b9bXM8ze//0xtAzO+i70e9pMMzEm0vm1JvrDteWXR2rJFMWpTFx4TFGDGV1rhrpdofXk0jyYpHc4gcmIpIttCq5UxCbG9BN2lb007FttfJty6GLL8BbWqjQu2tZQ3u0Ua0cK9EW/krL8EjDNCkN+eUS9MbvG1HnC18W/jmBBmL6dNEmHdJxcaqGcycIXhI3ag8zlu62MGUCTPqF9qJ0fBIOGJb5AptMkjntUvNbc4GhNaH/l3Sn1G/pjC2dKfcLfnpsH694Q6EnMkTH7pX2fFKR0NaEvO/rq4LrKxF1GvoSBfrR2rlVvKixbb1HzII6YmSHF0K/E5wALPqY/tNfEX6JkYjWycujXJT/KnsIXn3zhTkWs41GeWMR5Zuenr/MloHs2v0gLAluayPRWrPL5lDLO+e/o/LqdTk0nGcw4c+94+673PFATFWnmWGXq6g9vSCmbvFcyabG2NLIwgAEkNTzgSssHFUsOwHIyN2jFaBxMO1haV8C1guC+0F+28vWNxOscGoryDlKCrfWI9a0mTLO93u5KPHHWNtvtV5XVsKPSr+ylltiEFkb2HyPK9oVGJl0U57wBBBY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8229e0-2abd-4c29-bbba-08de59b678c0
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 13:02:17.8752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wr6S35xZsOCF+myW9digSLJgfZy/1gqmjOyo/cxLwoyYYu6mfJZwuQnUXbb9D3nYeqhRwf+ogeoqBoR0q3fNSFcKrfpKoCExbizpADcy1M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8198
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220097
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA5NiBTYWx0ZWRfX3yNHbdgRXTkx
 FBE9/4slKKmUzBBCGvQj7wd3VAMUVYYtxS+cQMQK9Jdt2dOr5f1oZow8vJahMaUXgEBFuQJaoyd
 NwVGGTC9jRyqx+hfMZteISRuiULkboOXjWuVErVxUiZsvTPgLIHw/PRZ8KwbVYwWdXc1Hvn4XCT
 I4OScL8UrdIPGjRVtHUu4xjMQb2fRxLbZmybbqUzTbWQL7156HlF7Hn+TwwQigtwvgnNAy09hKw
 DmmT5VtEpVMvrY8KWykpkAv2M1jDjTu/QlvFzH07HhvFfJTR+J4w7eNx8PfqUNVeAnkMMpUX9uM
 4H1ASRbpsLtuCZq6l3uiwF/NNadrO9R/2gSu9nKG+e72pnQhr+mOay4U/37SeP+Fc8obgBnMG0D
 DatycwQolNX4l/gxzWF7pjS7zyNBiiAs1eRdIiY+Sx7pPEn0tW4n7Pa28NjVE66AzeX3Ju9/9Bs
 pfZRVj8VHypzgNf8X7wR8i8m3UBiZFM6We6J7fQY=
X-Proofpoint-GUID: 6s4hHaE-xMFlcWnnZ7ogS7Wr6hmGlBE8
X-Authority-Analysis: v=2.4 cv=XK49iAhE c=1 sm=1 tr=0 ts=69721fdd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=yBRV7UiJsV_3HBrqTEMA:9 cc=ntf awl=host:12103
X-Proofpoint-ORIG-GUID: 6s4hHaE-xMFlcWnnZ7ogS7Wr6hmGlBE8

The function is a little confusing, clean it up a little then add a
descriptive comment.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mmap_lock.h | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 873bc5f3c97c..b00d34b5ad10 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -252,17 +252,30 @@ static inline void vma_end_read(struct vm_area_struct *vma)
 	vma_refcount_put(vma);
 }

-/* WARNING! Can only be used if mmap_lock is expected to be write-locked */
-static inline bool __is_vma_write_locked(struct vm_area_struct *vma, unsigned int *mm_lock_seq)
+/*
+ * Determine whether a VMA is write-locked. Must be invoked ONLY if the mmap
+ * write lock is held.
+ *
+ * Returns true if write-locked, otherwise false.
+ *
+ * Note that mm_lock_seq is updated only if the VMA is NOT write-locked.
+ */
+static inline bool __is_vma_write_locked(struct vm_area_struct *vma,
+					 unsigned int *mm_lock_seq)
 {
-	mmap_assert_write_locked(vma->vm_mm);
+	struct mm_struct *mm = vma->vm_mm;
+	const unsigned int seq = mm->mm_lock_seq.sequence;
+
+	mmap_assert_write_locked(mm);

 	/*
 	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
 	 * mm->mm_lock_seq can't be concurrently modified.
 	 */
-	*mm_lock_seq = vma->vm_mm->mm_lock_seq.sequence;
-	return (vma->vm_lock_seq == *mm_lock_seq);
+	if (vma->vm_lock_seq == seq)
+		return true;
+	*mm_lock_seq = seq;
+	return false;
 }

 int __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq,
--
2.52.0
