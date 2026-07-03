Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AFA38A73F;
	Fri,  3 Jul 2026 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082632; cv=none; b=FI457o9ayfPsYLQLXZlioIKXgFS4XtJJHzd5oRwjw5OzIURAB1FRngt7aMF/xyFpO29+I8tzO7tCPILYU4PCw7Ryr4Iwr4OAOgEin+5FytSI20wsq4CRWifPKcvtNIijmJk5w4c4+AbjGRJB1kfPe+4Jh5R0VlczZZtUWvEZDVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082632; c=relaxed/simple;
	bh=mOW1AWu5rJrc1L7wzcJy1SQ+MhN83pEdNJO6TXyCAzU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PyUZhH6lUKpaJY65jAk8jGCQ9xK6nGkD6UNhLAHhEA8gcwNvYA5CdUO863a12G0HiCoDYf9fu8GhXCrl5YfaPEZb7ZCHYXWTpa2wEui9X5dZnQEBK444cxJs0eJ3VNrvvcZd59Ddj5VhVCXaaGVv+9QgNxciWhHfWQ8MjQERvrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7L5Dqfb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7L5Dqfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239961F00A3A;
	Fri,  3 Jul 2026 12:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783082631;
	bh=aoHKH9Fr1hEMr42yc0mWTvDPqktXs3Mzoi0qgvpXw3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T7L5Dqfbux8lVPTfWwVbkUmc95muhePXAw1Kh2ypKSQhebKp6A18pABCFnaS/VaY7
	 nMXMB89C4iw4PmA/3d8wsALVFhuK3uLgru4K7KOeaUUWs+bWx5nJPknAMRHce3Kv5K
	 bz6mxp71GUUzyBFL/DzJj55iKNsX5rshsShuIxfZ+02hepk+HCbZ5r4e0sC3PnayXq
	 dWNeXslWMjmPEw5VeAVFjw3GVypc4A43eMQTlI3E+IPMRJZ95r1xSZg9EudMyVwi6Z
	 zsNcCYpeL/weTrQgnoDcmiVTuVoh6j/9/iDLqA3lz2vaxHZfj+VVVmTGt1o/ke0QuH
	 3/m06b7eYsePg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/18] mm/page_alloc: relax GFP WARN in nolock allocs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260703-alloc-trylock-v5-6-c87b714e19d3@google.com>
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <20260703-alloc-trylock-v5-6-c87b714e19d3@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:43:50 +0000
Message-Id: <20260703124351.239961F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The kernel-doc comment for the public API `alloc_pages_nolock` was =
not updated to reflect the relaxed GFP flags.
--

commit 311d28c3e8fc444b6e80f8dca47557fd6cfebc1f
Author: Brendan Jackman <jackmanb@google.com>

mm/page_alloc: relax GFP WARN in nolock allocs

This commit relaxes the VM_WARN_ON_ONCE check in nolock allocations to
allow flags included in gfp_nolock. It updates the validation to permit
callers to provide a wider set of flags safely.

Link: https://lore.kernel.org/linux-mm/ajS96fWbG4dzP3u3@casper.infradead.or=
g/

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f47a848555077..c2839959d7908 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5355,7 +5355,8 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp,=
 unsigned int order,
>  		return NULL;
> =20
>  	if (alloc_flags & ALLOC_NOLOCK) {
> -		VM_WARN_ON_ONCE(gfp & ~__GFP_ACCOUNT);
> +		/* Certain other flags could be supported later if needed. */
> +		VM_WARN_ON_ONCE(gfp & ~(__GFP_ACCOUNT | gfp_nolock));

[Severity: Low]
Does the kernel-doc comment for alloc_pages_nolock() also need to be
updated to reflect this relaxation?

Currently in mm/page_alloc.c, the documentation still states:

 * @gfp_flags: GFP flags. Only __GFP_ACCOUNT allowed.

This might mislead callers who refer to the API documentation into
believing they can strictly only pass __GFP_ACCOUNT, even though the
implementation now permits other flags included in gfp_nolock.

>  		if (!alloc_nolock_allowed())
>  			return NULL;
>  		gfp |=3D gfp_nolock;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-alloc-tryl=
ock-v5-0-c87b714e19d3@google.com?part=3D6
