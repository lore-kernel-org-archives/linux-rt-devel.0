Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035BA41C71
	for <linux-rt-devel@lists.linux.dev>; Tue, 23 Jun 2026 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207039; cv=none; b=sBxNQuTYKkRU0o0yzZhNmJWkg+T8AMrI7IgZPEvTej/DSpmsuufWLd10fyFvrXBl3k+y0FS877vT7A8BTRf725z7Vr4XgltI3CXBEZqZcbhKduIWwaB40gvVY7myx+7bqq/tc8Jq7LsBwL3jY4XAfU3wOcajLdIm9tnzeVqPSI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207039; c=relaxed/simple;
	bh=fysXveFrGl+xOjESs45HninEzPcTZNm96UsPzXWUmSU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TAe1yC9Ws5Hfqf7cK5BTZTdTnAv8J6lmQZT4nGaUVgjVJ6NTb+XQFGypKpkzPwsOPehimraeKjIBqnZRzAUMrJXqCf8OQmDwMsrSCDzEx28uRVbVF9GQ+d6h6I/0ceGAT9p2tWAsMTnCAElwziRTFih201DSV2X8EP2PE+WqPlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bUm2qcJd; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bUm2qcJd"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782207035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TPt0XsEDlnfRhDI3WReRswBGq2sEbpAABGyvTSlfps=;
	b=bUm2qcJdgZv9DExazrg3Q6bIImEbma9td2pMCBYkWi4sz2PL0Vlfp29zLXs5sYq6MVv/FN
	MYM6nFk9YPSsvUbJuqKdihidmF0AtQbTnZjCis+zqibBQmcGJlA3IyeFlUP0CqZ17Db/C9
	jMb9jWvi9G8nCXgfm1jkt9e+mjOH964=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 09:30:14 +0000
Message-Id: <DJGBNRPIEYRP.1XDOBS7YGKO1P@linux.dev>
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
 <sashiko-reviews@lists.linux.dev>, "Brendan Jackman" <jackmanb@google.com>
Subject: Re: [PATCH v2 12/13] mm: Move __alloc_pages() to mm/internal.h
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Hao Ge" <hao.ge@linux.dev>, "Brendan Jackman"
 <brendan.jackman@linux.dev>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-12-31f31367d420@google.com>
 <20260622102105.53D141F00A3A@smtp.kernel.org>
 <DJFJ96IPBX9H.33CCUBF385H1W@linux.dev>
 <037178f2-bd9e-4766-8df1-0881e2eee9c1@linux.dev>
In-Reply-To: <037178f2-bd9e-4766-8df1-0881e2eee9c1@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue Jun 23, 2026 at 6:50 AM UTC, Hao Ge wrote:
> Hi Brendan
>
>
> On 2026/6/22 19:14, Brendan Jackman wrote:
>> On Mon Jun 22, 2026 at 10:21 AM UTC, sashiko-bot wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
>>> - [Low] Missing EXPORT_SYMBOL for out-of-line alloc_pages_node_noprof()=
 causes widespread module linker errors.
>>> --
>>>
>>> commit 42f7742177beb0066c00a7aa081250feb5859171
>>> Author: Brendan Jackman <jackmanb@google.com>
>>>
>>> mm: Move __alloc_pages() to mm/internal.h
>>>
>>> This commit moves the __alloc_pages() family of internal functions to
>>> mm/internal.h to restrict them to the mm subsystem. It also moves
>>> alloc_pages_node_noprof() out-of-line into mm/page_alloc.c since it
>>> depends on __alloc_pages_noprof().
>>>
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index 36f0d625a4390..38238203ef7b0 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>> [ ... ]
>>>
>>>> @@ -5419,6 +5419,17 @@ struct page *__alloc_pages_noprof(gfp_t gfp, un=
signed int order,
>>>>   }
>>>>   EXPORT_SYMBOL(__alloc_pages_noprof);
>>> [Severity: Low]
>>> Since __alloc_pages_noprof() is no longer visible outside of mm/, shoul=
d this
>>> EXPORT_SYMBOL be removed?
>> Yep.
>>
>>>> +struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigne=
d int order)
>>>> +{
>>>> +	if (nid =3D=3D NUMA_NO_NODE)
>>>> +		nid =3D numa_mem_id();
>>>> +
>>>> +	VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES);
>>>> +	warn_if_node_offline(nid, gfp_mask);
>>>> +
>>>> +	return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
>>>> +}
>>> [Severity: Low]
>>> Does this code cause module linker errors? alloc_pages_node_noprof() is=
 called
>>> by the alloc_pages_node() macro in include/linux/gfp.h, but it does not=
 have
>>> an EXPORT_SYMBOL.
>> Yep. Doesn't show up in defconfig but if you set CONFIG_BLK_DEV_UBLK=3Dm
>> then:
>>
>> ERROR: modpost: "alloc_pages_node_noprof" [drivers/block/ublk_drv.ko] un=
defined!
>
> I was about to report this linker issue myself, but Sashiko caught it fir=
st.
>
> While testing your patch on top of mm-new, I hit the exact same modpost
>
> undefined symbol error as mentioned above:
>
>  =C2=A0 MODPOST Module.symvers
> ERROR: modpost: "alloc_pages_node_noprof" [arch/x86/kvm/kvm-intel.ko]=20
> undefined!
> ERROR: modpost: "alloc_pages_node_noprof" [arch/x86/kvm/kvm-amd.ko]=20
> undefined!
> ERROR: modpost: "alloc_pages_node_noprof" [drivers/gpu/drm/ttm/ttm.ko]=20
> undefined!
> ERROR: modpost: "alloc_pages_node_noprof" [drivers/misc/sgi-xp/xpc.ko]=20
> undefined!
> ERROR: modpost: "alloc_pages_node_noprof" [drivers/misc/sgi-gru/gru.ko]=
=20
> undefined!
> ERROR: modpost: "alloc_pages_node_noprof"=20
> [drivers/net/ethernet/amazon/ena/ena.ko] undefined!
> ERROR: modpost: "alloc_pages_node_noprof"=20
> [drivers/net/ethernet/amd/xgbe/amd-xgbe.ko] undefined!
> ERROR: modpost: "alloc_pages_node_noprof"=20
> [drivers/net/ethernet/aquantia/atlantic/atlantic.ko] undefined!
> ERROR: modpost: "alloc_pages_node_noprof"=20
> [drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko] undefined!
> ERROR: modpost: "alloc_pages_node_noprof"=20
> [drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf.ko] undefined!
> WARNING: modpost: suppressed 14 unresolved symbol warnings because there=
=20
> were too many)

FWIW something like this happened on a previous patchset of mine, and
someone was like "so you just sent patches without any testing huh?" so
I just wanna note: I did test this (see cover letter for details) I just
don't bother with modules!

Anyway, this is the 2nd time I've sent a patch that breaks the build of
CONFIG_KVM_INTEL=3Dm so I guess it's time to add a new build to my test
scripts :)

