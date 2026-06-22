Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91F3A543A
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123730; cv=none; b=uv1d2Rks55eS060JCnB83ut8rgVf5qRikUFRYG+BrWSkQu1ZLL4Ni6yBljrGmWbw75YDYt28d7HwZx7eCki6qa5LJUwi+f7lkSHksA+h1DeahgkjCGcYkRgdVRecIAX21+vfKRIosxqe6ePF7y2d/Q1TOi7WyR8iMeVsyGBBzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123730; c=relaxed/simple;
	bh=xebV3xo6W9s6HMqQ6krEGpAVgS69KlGdC6YZUzOoXJU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qPC5t1ooCUYDREOkyUVBuDA/0dAJ/SbLvWqvDXK1gKaS6x5rT/0AmEp9ApP6+t6SQBHFLH+8TLNUQ3VQhH3togR0AAy3xJDBrejq6Vio3c5ilcHnqy8t2qT74flhN0r1HsFPWTSdBrkWAI5z81dixCpcnPGjpD0HPfv1oIubO/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jeuGsO0o; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jeuGsO0o"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782123727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xebV3xo6W9s6HMqQ6krEGpAVgS69KlGdC6YZUzOoXJU=;
	b=jeuGsO0oOIr4aYAxgA1n4dgifjrxCjLRXpvmW6+HhS6kVWQUMRQzq5654q3xSp/1lIvb5m
	FG4c0GeEaVjZjHgCTN32z1hygtmW8GBpsjdG13frdNEeIBHvr3EvStjD6ERzTUofVaQGgy
	A7jWYGgEFYTrSzX6uJGBF3wCXdkdjaU=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 10:22:04 +0000
Message-Id: <DJFI4X0FKFNJ.30HDYS6YXK76D@linux.dev>
Cc: <linux-rt-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/13] x86/virt: Use higher-level allocator
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: <sashiko-reviews@lists.linux.dev>, "Brendan Jackman"
 <jackmanb@google.com>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-7-31f31367d420@google.com>
 <20260622101215.5A3AF1F000E9@smtp.kernel.org>
In-Reply-To: <20260622101215.5A3AF1F000E9@smtp.kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon Jun 22, 2026 at 10:12 AM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] Commit message factually misstates the difference between __alloc=
_pages_node() and alloc_pages_node()
> --
>
> commit ec153a4ff69fcf9b29806faedae74ed9c08f7dda
> Author: Brendan Jackman <jackmanb@google.com>
>
> x86/virt: Use higher-level allocator
>
> This commit switches the __x86_vmx_init() function to use the higher-leve=
l
> alloc_pages_node() function instead of __alloc_pages_node(). The code cha=
nge
> itself is safe and functions correctly.
>
>> The difference between __alloc_pages_node() and alloc_pages_node() is
>> that the former allows you to pass NUMA_NO_NODE.
>
> [Severity: Low]
> Is this description accurate?
>
> Looking at the definitions, __alloc_pages_node() explicitly contains a
> VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES), which forbids passing
> NUMA_NO_NODE (-1).
>
> Instead, alloc_pages_node() is the one that explicitly handles NUMA_NO_NO=
DE
> by converting it to numa_mem_id().

Repeating myself[0] as this patch has a different CC list from the others:

Sashiko is correct, the commit message says "former" but it should say
"latter".

[0] https://lore.kernel.org/all/DJFI39RWHV1O.MMMMMZSK8E8C@linux.dev/
