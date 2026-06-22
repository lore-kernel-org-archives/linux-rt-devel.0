Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675603A543F;
	Mon, 22 Jun 2026 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123667; cv=none; b=Fw7i8hqywLUjCn9HcbFY5ZJth3B9fJPvCjlmEWMsngqSVKxApdXDqHS/8cJSw7lRdlHIebLe7yVeKwZen5rLDfV2jC512TFsjzr0gFR8FYw3P1fnYI/ahMWTi5VfhUxScotooeiP3+p5WJGaf+8SgPxd017JZUdGwsLuUrNLnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123667; c=relaxed/simple;
	bh=2iVDTY2anQGxmPaRwZ+gttbzPYSxqWwNqu1J8EO89uE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gOLnHD7GLK/GKVtiNRUnlq3eFqk/oMTFXJ4pLrCh4l0iCCrxFBQNLcVZ1KOqpQDELoFOPuztY2rqGe1wk06Bzb/Nl3Q+xu1BgLftarzE9qB4nOmNa16JfUSaSb0I0C21ZYWgDmab+9VwmM5NT9PuJ0ZHK90iMgNoRn4g1whnxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xw1sufSc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xw1sufSc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D141F00A3A;
	Mon, 22 Jun 2026 10:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782123666;
	bh=66ycnKEYFqIqB2b70C0ShtabGIBXAcrjO5dyPwAQE8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xw1sufScglBNRRgzfh88xEuuTez+PIrXDk/tiB6t16AfPkDNGZg3Slc07aeRDs0Cr
	 Yk0e982ddx3CdDKJI3ztuQsnRI7YmqDBfIFfLEHQoGHrlKmk5nJ/xJA76uph7XLJ0p
	 vBAHWDAQLhC8Eht/7Uc100o91OGWskfPgW97jKYCqYnTORrEvUG02CcMnCZv+xNhNY
	 YgQ/1tdUyZmfIUFSYg1W0AD3r6pzfK2IQOFT1DiZ+y/Hn3zSzT3Jim9NiLhSizm718
	 k/CMpEohKX9bxTzlf/0zXqDrs6VKkQbg0h0P5i43xj8f4/YVczG/ktEuVqJ97YLL6o
	 DxLZBU0Fb33wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/13] mm: Move __alloc_pages() to mm/internal.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260622-alloc-trylock-v2-12-31f31367d420@google.com>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-12-31f31367d420@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 10:21:04 +0000
Message-Id: <20260622102105.53D141F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing EXPORT_SYMBOL for out-of-line alloc_pages_node_noprof() cau=
ses widespread module linker errors.
--

commit 42f7742177beb0066c00a7aa081250feb5859171
Author: Brendan Jackman <jackmanb@google.com>

mm: Move __alloc_pages() to mm/internal.h

This commit moves the __alloc_pages() family of internal functions to
mm/internal.h to restrict them to the mm subsystem. It also moves
alloc_pages_node_noprof() out-of-line into mm/page_alloc.c since it
depends on __alloc_pages_noprof().

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 36f0d625a4390..38238203ef7b0 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c

[ ... ]

> @@ -5419,6 +5419,17 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsig=
ned int order,
>  }
>  EXPORT_SYMBOL(__alloc_pages_noprof);

[Severity: Low]
Since __alloc_pages_noprof() is no longer visible outside of mm/, should th=
is
EXPORT_SYMBOL be removed?

> +struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned i=
nt order)
> +{
> +	if (nid =3D=3D NUMA_NO_NODE)
> +		nid =3D numa_mem_id();
> +
> +	VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES);
> +	warn_if_node_offline(nid, gfp_mask);
> +
> +	return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
> +}

[Severity: Low]
Does this code cause module linker errors? alloc_pages_node_noprof() is cal=
led
by the alloc_pages_node() macro in include/linux/gfp.h, but it does not have
an EXPORT_SYMBOL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-alloc-tryl=
ock-v2-0-31f31367d420@google.com?part=3D12
