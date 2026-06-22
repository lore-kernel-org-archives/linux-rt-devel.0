Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A26239EF23;
	Mon, 22 Jun 2026 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123026; cv=none; b=JyyfX/kKAsJLCrBCoU+XOYHvxfzwSRQ9TIzD6XaeUvSl9X207+UNwLMfQCL+2Sz3NFp799+wmkZn8uPZfXhXZ312mwKRWFJVd6Xxu87hJvDL9bt1fFfhOzOZXgNV1JJ5mJlWAjLukp4hoJLUMAb2D+hqKjyrDVv7U0PAoEjLTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123026; c=relaxed/simple;
	bh=SpDqN+EHLuwefGupwoMOgP8Mc9LtoEDrc49pe0FR1GY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KieXOudEkZwTdPHkO427WUzM88NBE0XWGf8K771SEVGP4+3C+LlFuIUO5OIORpS3tW1iXLhi5AOMRv4f3r7Ib6lkhbTy84ZTQZHmbj9LXRMC1puYyMjIrww6ek1ahfsDiVT1LluWVxKcXffeZukiOksmneWlb14dHCeF/Hn4Leg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGO/Y+kx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGO/Y+kx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89C21F000E9;
	Mon, 22 Jun 2026 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782123024;
	bh=IQW0UUoQjuPZClNIQEShqApbLMZ1hkKZJJ5crtglHJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fGO/Y+kxBAcd0i+fVzHHT8MZWP+hV3xfl6qLRXbZFcZq7zbcfIyxLkS7TbOEkRt8a
	 2W/uyhXFquSDlNwZHKG1BhKbXOZrmo9b9hW7SPX/4K9/e2ovibHCyatyTuo4+kfNTn
	 geI+sJ7yRE9VElIftfZZ5NBYDUVaETjzsfQA7MYYPQqDWNZ7J8ND8usMIfLHRQJG0A
	 nuDWOmzwtlJKmWxYbygIJp1DjfcuBt9AhTqCdbiFauScL8mYvxTrVGAmUVIKbaPcky
	 6amBsMPgNpxAfRharLCUefTzPZOshnwQRSWpjVpFfh7DmhE/qK30A39k8qPaylJaup
	 bCmbSVMmu2uPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/13] perf/x86/intel: Use higher-level allocator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260622-alloc-trylock-v2-5-31f31367d420@google.com>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-5-31f31367d420@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 10:10:24 +0000
Message-Id: <20260622101024.B89C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message factually misrepresents the API differences b=
etween `__alloc_pages_node()` and `alloc_pages_node()`.
--

commit a5667683e56825d97c5814c0349e4de3300e3e14
Author: Brendan Jackman <jackmanb@google.com>

perf/x86/intel: Use higher-level allocator

This commit switches the memory allocation in dsalloc_pages() from
__alloc_pages_node() to the higher-level alloc_pages_node() function.
It also updates a comment to reflect the API change.

> The difference between __alloc_pages_node() and alloc_pages_node() is
> that the former allows you to pass NUMA_NO_NODE.

[Severity: Medium]
Is this description of the API differences accurate?

Looking at include/linux/gfp.h, it appears the capabilities are actually
reversed. alloc_pages_node() is the function that explicitly supports
and safely handles NUMA_NO_NODE:

include/linux/gfp.h:alloc_pages_node_noprof() {
    if (nid =3D=3D NUMA_NO_NODE)
        nid =3D numa_mem_id();
    ...
}

Meanwhile, __alloc_pages_node() expects a valid node ID and contains a
VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES) check, which will crash if
passed NUMA_NO_NODE.

Could the commit message be updated to clarify that alloc_pages_node()
is the API that safely handles NUMA_NO_NODE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-alloc-tryl=
ock-v2-0-31f31367d420@google.com?part=3D5
