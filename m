Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7852943DA31;
	Mon, 29 Jun 2026 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748960; cv=none; b=huGiiBJZnTMOWSBJe0P5yk0gqkfQMIZu4x+4VhthrL3CzStkqy5y/eUxlCNs6xKsVABMW/Q10fIyxIurT4ySs4vyqtU1jyXYE7VbjmEReqBaGJJ8yA7xbbnbxWMyhfEu5u49VRFkQYP9bbJzGlh4p4/j341W6K0byHERgqDPAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748960; c=relaxed/simple;
	bh=QiyfD++GA9IqpBkqLytorFprOh+wnWNbYWW3YYpYv4A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xt/VHxxJEUjqzIdSUctcgAak7KwR3WieKCtTPPFszOS2WPo8XSfyoHdtU8kDqj/t3ajsqiEDZejYxt0h3KBXStEKJPTei5gJas7L3FkAos4ibS50tcTMcImM76KSTuwRk/RuUrYR2IhxrAhQcFHJI5NtAJDTSjpEKmyCkkaMjok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBv20ohD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBv20ohD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334E71F000E9;
	Mon, 29 Jun 2026 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782748959;
	bh=rA+ZlR4PqSL3f4EQwjnrtbIhurXdhubNbZIHjy3FMXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eBv20ohDXLmakGHmxY50dOaJpfQjx9XcWncKFDPWGN3R87stuw/3k75olPErMeQdU
	 YO/BMoaBajfdi72Q4VClLbWdYrt/0+08T/mcak0Fyc3vdJep2Xnzk1tfh750gfl0kz
	 NwIVvllCxNU3gHaEMw9eMbiArIdk086+IgbiVfBfhqsCXr7lBEBZ96OTDpyHhW7hXo
	 JJR2EoaPmA5NEYh3CNxQVC22SoR5+ypXTVbuVVidL8ASedNMO8RCv+eGxEe7OTrC1j
	 5XjRtcoVG62cxHdeWp4eujERVXaSiood+3GOgP9Dk/0G46zUzyW+ENX42XfJSfnT1Y
	 BadhC6cfi+AiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/16] mm: remove the __GFP_NO_OBJ_EXT flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260629-alloc-trylock-v3-16-57bef0eadbc2@google.com>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-16-57bef0eadbc2@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 16:02:38 +0000
Message-Id: <20260629160239.334E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete removal of `__GFP_NO_OBJ_EXT` flag leaves the bit res=
erved in the core kernel.
--

commit d2006cc547e302003b4c27943f81bc40cdd90223
Author: Brendan Jackman <jackmanb@google.com>

mm: remove the __GFP_NO_OBJ_EXT flag

This commit removes the __GFP_NO_OBJ_EXT flag from the tools copy of
gfp_types.h. Its previous users have been converted to use
SLAB_ALLOC_NO_RECURSE or ALLOC_NO_CODETAG instead.

> diff --git a/tools/include/linux/gfp_types.h b/tools/include/linux/gfp_ty=
pes.h
> index 6c75df30a281d..a93b8bd200b76 100644
> --- a/tools/include/linux/gfp_types.h
> +++ b/tools/include/linux/gfp_types.h
> @@ -55,7 +55,6 @@ enum {
>  #ifdef CONFIG_LOCKDEP
>  	___GFP_NOLOCKDEP_BIT,
>  #endif
> -	___GFP_NO_OBJ_EXT_BIT,

[Severity: Medium]
Is it possible that the core kernel header updates were missed? The
changes in this patch only modify the tools copy of the header, which
causes it to diverge from the actual kernel definitions.

Looking at include/linux/gfp_types.h, ___GFP_NO_OBJ_EXT_BIT remains
reserved in the core kernel. Additionally, the trace event mapping
TRACE_GFP_EM(NO_OBJ_EXT) is left behind as dead code in
include/trace/events/mmflags.h.

Could the removal be applied to those files as well so the bit is fully
freed in the core kernel page allocator as described in the commit
message?

>  	___GFP_LAST_BIT
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-alloc-tryl=
ock-v3-0-57bef0eadbc2@google.com?part=3D16
