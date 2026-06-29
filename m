Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25F640D57F
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760583; cv=none; b=BoZCGKS9qlvSkmLWJEFcWa/2v/b4z6k73POcTnmbt7P4xt1MJGrrs/hQjnAMO/4AoPmdH1kf6Uz/+t9ksCSRUz73EB5QqDCiUZT/2jUUyGChMIPR9lgRTCDObLcA0W3A1hkNT4rc0NT2PItL8P6V8BqISriy90GTZ/5ffIPc834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760583; c=relaxed/simple;
	bh=B+JW8Wx0v8LUjxtguOlwuXTOJRQ4CoL2zYqvPlw+7o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2ttKX0vHBqnXGbdWHmHzHBJ0/Dw6iSyJMV1tK+XYPAOs435t5+F4WZbK7+utTaZ0xVsJ+MKAHO0nFYZ+IV+iqAmJg4Tietq9wDMwhR5zTshzlloQ37eSY4s3re5Uw0Qe0o+6JwaW+hualx79ddE7IrOoz+FJ7va5+nkWpYD67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=hr/8LVFX; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="hr/8LVFX"
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TGOQkG4133301;
	Mon, 29 Jun 2026 18:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=b6grvcm5OGpU1yotvwOUMnvDfj
	QUFC5kGrd/zcVEo6w=; b=hr/8LVFXPUgVv1E5w7E72LHD1lUZpnGwKxOD/qMd7d
	mhLsua0tMqEjK5DVhygd5w9nR4Ro+T3TU5xRbULJbfgaopuEuvKY0uB1mdYLscQy
	4r34dGwkUqAkdX5/qg1j8EZpTLcdSNCeXu199aZuZDThMRKKXVJIwJ7QnQb7w8Fk
	3A1sff0bwnEHGuJwSyUHMtseQ/7CPSb7/LKox+aaZf4gN3QLlSCZ3IWCSGd4cJ8b
	wdEhR/YF+CjHwf76fQFu7cvnaaswaDJRWeOnKIabijExIU+69KQXfB83rpmC+wNg
	UfboKobtHnL2BmMkp3aGn0KyC96ivmMkvDDVb5BDnfEQ==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4f3tcw4uj1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 18:47:31 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id AFFFB8005EB;
	Mon, 29 Jun 2026 18:47:28 +0000 (UTC)
Received: from ilogsc-qemu.local (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id D3553800DBB;
	Mon, 29 Jun 2026 18:47:21 +0000 (UTC)
Date: Mon, 29 Jun 2026 13:47:19 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Hao Li <hao.li@linux.dev>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Harry Yoo (Oracle)" <harry@kernel.org>,
        Gregory Price <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Hao Ge <hao.ge@linux.dev>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, Robin Holt <robinmholt@gmail.com>,
        Steve Wahl <steve.wahl@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 11/16] sgi-xp: Use higher-level allocator API
Message-ID: <akK9tyvmlxteOIEE@ilogsc-qemu.local>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-11-57bef0eadbc2@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-alloc-trylock-v3-11-57bef0eadbc2@google.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE1NyBTYWx0ZWRfX4oaEEQu+svmh
 0jQDLkECSkLwUn9O+GVSj9ncpGy0ldhn9YZNf7JNtMco1kMowk9dekwegGksnr1GOVydqunPA+W
 896kaunTIng1vV7ykQtNfH628d+QAoU=
X-Proofpoint-GUID: DIIV3Dhu-pescEAUPkMHsSecUf7k0d_D
X-Proofpoint-ORIG-GUID: DIIV3Dhu-pescEAUPkMHsSecUf7k0d_D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE1NyBTYWx0ZWRfX79YLrz1gyDlD
 uC0D9FOuiDClqFB7aXc9EGCr21byWM+1L9a6GCi2dcRjXPZbQDqg0ch3QKWHUg7rbMXUAE+KD67
 R7tbqZQBCPqGCfw9T9flkIvSuemRunrcIHAmfompNuuxmvF6m5e1QJkdKGzrJqXUOQdjYeJJKte
 AzqVAxLxCS+EnQLh56QT86ctyRUwmVNyuPzDD7XQheODs3u5SxwmgqzLjuaj/+gti852ws1S4Zz
 cLIChd3Q6MLUGO7iCVVMHpT1MiDIQu+O4Tb05RfaW1gNYADcIGr/pB+/7YaT8+FdtTW59/499CA
 JXmrozO1CoHBmL03re8aEtG/S6a7J6DJEF8758+eLH+rFJEmWUXRAPT7KBFi+h9jwNlM2zaCiAU
 /G4KWigHXXH/KyWENqbXoT1MYtds8YXfZt8ovEgY5HWnIatXZQB/EAGoZx23a0UCke0TDcfbVZ2
 OvtaOWQiYvlJtyjZfoQ==
X-Authority-Analysis: v=2.4 cv=f6t4wuyM c=1 sm=1 tr=0 ts=6a42bdc3 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=_ZmgHqWwjZUDpi_pur5s:22 a=MvuuwTCpAAAA:8
 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=1XWaLZrsAAAA:8 a=g10eFjkI4RNaiMiBvy0A:9
 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290157

Acked-by: Steve Wahl <steve.wahl@hpe.com>

On Mon, Jun 29, 2026 at 01:12:00PM +0000, Brendan Jackman wrote:
> The difference between __alloc_pages_node() and alloc_pages_node() is
> that the latter allows you to pass NUMA_NO_NODE.
> 
> The former is going away and the latter works fine here so switch over.
> 
> No functional change intended.
> 
> Cc: Robin Holt <robinmholt@gmail.com>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Assisted-by: Gemini:unknown-model
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  drivers/misc/sgi-xp/xpc_uv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
> index 772c787268932..aacff70204241 100644
> --- a/drivers/misc/sgi-xp/xpc_uv.c
> +++ b/drivers/misc/sgi-xp/xpc_uv.c
> @@ -170,7 +170,7 @@ xpc_create_gru_mq_uv(unsigned int mq_size, int cpu, char *irq_name,
>  	mq->mmr_blade = uv_cpu_to_blade_id(cpu);
>  
>  	nid = cpu_to_node(cpu);
> -	page = __alloc_pages_node(nid,
> +	page = alloc_pages_node(nid,
>  				      GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
>  				      pg_order);
>  	if (page == NULL) {
> 
> -- 
> 2.54.0
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
