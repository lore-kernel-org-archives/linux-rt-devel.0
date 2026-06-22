Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8673A4F51;
	Mon, 22 Jun 2026 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123137; cv=none; b=jI7aaGt1bH6KUpT+P0ij/KgXkAjWx8nhQnUtfG/zzDlDTG8mtDnZUFimWWWvSo/9ncBsld0qfbxeHKzA45YH/KoX/HjEjD7kV7+u2fuaiy6k26LTtwdadAeHihfCdiXI8Bg6dQ68V93lWwMA6BYh0GTOrXqCHNLPKbUl7TBRo1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123137; c=relaxed/simple;
	bh=eN8Dg2cTykL+AFKXsBgXEZlYpkbwhjsWpPFedhe5piw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k9HlVN97lE4uNj3ZFTvfkGDo7pPO35FgSzZJgI2ciyaUtzVrIkSIpN2nZOrpNMxdh/wwFmJ73dnSb5IVcWAPEw9TdzL+fQm6s7F8R+X31KbYe3gNCguzvamy1uHMKcJ2f8cux+NRT16PCsqUh4adxO0f2SET9SHcEinls2+yJ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L06uYSGj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L06uYSGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3AF1F000E9;
	Mon, 22 Jun 2026 10:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782123135;
	bh=eN8Dg2cTykL+AFKXsBgXEZlYpkbwhjsWpPFedhe5piw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L06uYSGjtd25obYdj/8h7qIFlxFMAQaIbUwTdJvCjplgkzWHdYXoFUB47AWLgznhO
	 t9Qb2tCr4uQKW6X+BdF/R8GVd3nYk53cuvaUn7juw/4SNnVBrWdXMcLwDT6TVaa4GT
	 eQOPX6eoNCccXpLSEms2CMhk4hAXUFwBOsnbDtji/OdpA7pM8xrSfPFeAxNUNI+Rm3
	 3Onle4CBa3XB9MnaA38yb/xge+6YJ7xlePGQ+T3rULiMxKzAOP1req21w/X6L8K3uq
	 hHo6S+HmLvUHtMqgEdljE5RCvLklBD+tPuW3fxoxDYJjUxmCuudP7eJL942yax1jRd
	 yTG1l5LRM0Ujg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/13] x86/virt: Use higher-level allocator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260622-alloc-trylock-v2-7-31f31367d420@google.com>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-7-31f31367d420@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 10:12:15 +0000
Message-Id: <20260622101215.5A3AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Commit message factually misstates the difference between __alloc_p=
ages_node() and alloc_pages_node()
--

commit ec153a4ff69fcf9b29806faedae74ed9c08f7dda
Author: Brendan Jackman <jackmanb@google.com>

x86/virt: Use higher-level allocator

This commit switches the __x86_vmx_init() function to use the higher-level
alloc_pages_node() function instead of __alloc_pages_node(). The code change
itself is safe and functions correctly.

> The difference between __alloc_pages_node() and alloc_pages_node() is
> that the former allows you to pass NUMA_NO_NODE.

[Severity: Low]
Is this description accurate?

Looking at the definitions, __alloc_pages_node() explicitly contains a
VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES), which forbids passing
NUMA_NO_NODE (-1).

Instead, alloc_pages_node() is the one that explicitly handles NUMA_NO_NODE
by converting it to numa_mem_id().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-alloc-tryl=
ock-v2-0-31f31367d420@google.com?part=3D7
