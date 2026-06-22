Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834AF36607D;
	Mon, 22 Jun 2026 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124141; cv=none; b=N45bMF+j87yQyOBF0wiRRjsnyw0kg59aji5p4CGIubChWSowibU+lkAuVFCf5Vb/pDQ+4gffYRxiTq54V5spCyGbVPEJN7+FOaTxv869e3IZn0xOcdAXo0xrlki1aaREQZhsyaM8X9OMhfEAWccxZ82aqPAMTFic30dDRWmcn+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124141; c=relaxed/simple;
	bh=0XX0KJjpUqWHUe9CZHDbeiLxAnkFJVumoKaX++Xr3C4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Kp9rxlcYyje8c6hNW/N2fVaFA/ilfoZYDZeyy6vmpxclE8N7SemaEaRne+bzlVc5WTqSsAF0D+3MG7o0uc0Fc8by0iyujRDlLJkkpgnxgFhDmG+hBap7edo4wn+NGnU4I4JZUwAHLOb8ON65L3a6b/WD+33gFtq2X3sS+yfNLnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eIr9CAso; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eIr9CAso"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782124137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SVOxiUEezHEZF8mwNIzn06/HTIuUjiG697/ZyJDY9vg=;
	b=eIr9CAsobVNYahHyunsgI0aThxJwpdLiiqjMx1Xdigx315rCORTr5OwBWbpSw0iHCJrGrt
	EK2sDlLXJNwV58d1pjXUZY0t2nnllMzghDOVQxZcFiPzFyjuwfpXJOaeRazmYa4GQKyJJe
	Xf9T4xeF2lJqvEvQnI2FeTk4ItQSO9Q=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 10:28:47 +0000
Message-Id: <DJFIA259L7L7.2IUKHG3JR51TP@linux.dev>
Cc: <linux-rt-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 10/13] mm: Remove __alloc_pages_node()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: <sashiko-reviews@lists.linux.dev>, "Brendan Jackman"
 <jackmanb@google.com>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-10-31f31367d420@google.com>
 <20260622101736.961F31F000E9@smtp.kernel.org>
In-Reply-To: <20260622101736.961F31F000E9@smtp.kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon Jun 22, 2026 at 10:17 AM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] The patch leaves `__folio_alloc_node()` exposed to the exact sam=
e CPU hotplug out-of-bounds vulnerability that justified the removal of `__=
alloc_pages_node()`.
> --
>
> commit b690a6726aee701f88a87b35d2db8bfbfa39bc05
> Author: Brendan Jackman <jackmanb@google.com>
>
> mm: Remove __alloc_pages_node()
>
> This patch removes __alloc_pages_node() because its usage with cpu_to_nod=
e()
> can return NUMA_NO_NODE during CPU hotplug, bypassing validation and caus=
ing
> out-of-bounds accesses on NODE_DATA().
>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index cdf95a9f0b87c..7edcc2e0be9ce 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -278,21 +278,6 @@ static inline void warn_if_node_offline(int this_no=
de, gfp_t gfp_mask)
>>  	dump_stack();
>>  }
>> =20
>> -/*
>> - * Allocate pages, preferring the node given as nid. The node must be v=
alid and
>> - * online. For more general interface, see alloc_pages_node().
>> - */
>> -static inline struct page *
>> -__alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order)
>> -{
>> -	VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES);
>> -	warn_if_node_offline(nid, gfp_mask);
>> -
>> -	return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
>> -}
>> -
>> -#define  __alloc_pages_node(...)		alloc_hooks(__alloc_pages_node_noprof=
(__VA_ARGS__))
>> -
>>  static inline
>>  struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, =
int nid)
>>  {
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does leaving
> __folio_alloc_node_noprof() exposed maintain the exact same CPU hotplug
> vulnerability that justified removing __alloc_pages_node()?
  ^^^^^^^^^^^^^ No, Sashiko-chan! Why are you disclosing this critical
	        vulnerability without an embargo!?!?!
>
> The commit message notes that passing the result of cpu_to_node() to the
> allocator can yield NUMA_NO_NODE if the CPU is hotplugged out, which
> bypasses validation and causes out-of-bounds accesses on NODE_DATA().
>
> Can this still happen with __folio_alloc_node()? For example, in
> net/sunrpc/svc.c, svc_prepare_thread() calls:
>
> rqstp->rq_scratch_folio =3D __folio_alloc_node(GFP_KERNEL, 0, node);
>
> with a potentially invalid node ID originating from cpu_to_node(). Should
> __folio_alloc_node() also be removed or updated to safely handle
> NUMA_NO_NODE?

Serious answer: this is discussed in the cover letter, leaving the
*folio* API untouched was deliberate.

(Not saying we _shouldn't_ make that change, but this patchset is
already pretty big and the __alloc_pages* changes had an ulterior
motive).
