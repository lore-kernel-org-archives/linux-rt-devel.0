Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18E3A453B
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123611; cv=none; b=e3AVx/fVdaSyHTtzbavGvdWJaQNhR1i7PQKFXee/hxRyYOWrR53AdOPsds/lp1ZlwODxnaenPQZnu4BkzKXEHpmGEV/haJ3MA9d9CArUgCae5Yr6TpIpuaNZIAq7hgE7e7gUmLgdxEdkWvC5EJ22wduMBNDMO5whZgasRFYyCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123611; c=relaxed/simple;
	bh=MkY6nlLFzSXoALDu4trn6baPHE1gTGNtf+3w8p0yrlc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=mIqDrILM8G/JYP+vFPP0xh7x9Vl1do3VyAUZdx2BdTcQMaZSxEV+36SkxL41k4IyFFMnZDi91pQVw71Voob/MYgirR4H6pJhvtv6xg4AoIoVlZNgdwig9Gi4yi/pLWSaT64leVCUR4vJmXkGnUQiLSiPioTy12r5hUA0M360wPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EEgc7dfM; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EEgc7dfM"
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782123598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61qKRNZwBJRNqSbrg5LXzvWIDIKcY6Z0oSAWz/l/52g=;
	b=EEgc7dfMyD99yO/FTdb6+fz9XHhfSzbmk35fMdpgVn12b3SbRbVOjnN5FVG0jChbniciKr
	d8Azf0IX/TvIgjVLYPDm4tZ+sYY1/G6iX4Z05LAhQDbCVB5xV2HyqNCn5NMehUwohR7eOk
	q94lKZPfqYN2VVZ0PdNFZvXycaNgJzQ=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 10:19:56 +0000
Message-Id: <DJFI39RWHV1O.MMMMMZSK8E8C@linux.dev>
Subject: Re: [PATCH v2 05/13] perf/x86/intel: Use higher-level allocator
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: <sashiko-reviews@lists.linux.dev>, "Brendan Jackman"
 <jackmanb@google.com>
Cc: <linux-rt-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-5-31f31367d420@google.com>
 <20260622101024.B89C21F000E9@smtp.kernel.org>
In-Reply-To: <20260622101024.B89C21F000E9@smtp.kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon Jun 22, 2026 at 10:10 AM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The commit message factually misrepresents the API differences=
 between `__alloc_pages_node()` and `alloc_pages_node()`.
> --
>
> commit a5667683e56825d97c5814c0349e4de3300e3e14
> Author: Brendan Jackman <jackmanb@google.com>
>
> perf/x86/intel: Use higher-level allocator
>
> This commit switches the memory allocation in dsalloc_pages() from
> __alloc_pages_node() to the higher-level alloc_pages_node() function.
> It also updates a comment to reflect the API change.
>
>> The difference between __alloc_pages_node() and alloc_pages_node() is
>> that the former allows you to pass NUMA_NO_NODE.
            ^^^^^^
    Sashiko is correct, that should say "latter".
>
> [Severity: Medium]

Seems like an inflated severity rating, this is basically a typo in the
commit mesage, and anyone that noticed it would probably have realised
what happened.

> Is this description of the API differences accurate?
>
> Looking at include/linux/gfp.h, it appears the capabilities are actually
> reversed. alloc_pages_node() is the function that explicitly supports
> and safely handles NUMA_NO_NODE:
>
> include/linux/gfp.h:alloc_pages_node_noprof() {
>     if (nid =3D=3D NUMA_NO_NODE)
>         nid =3D numa_mem_id();
>     ...
> }
>
> Meanwhile, __alloc_pages_node() expects a valid node ID and contains a
> VM_BUG_ON(nid < 0 || nid >=3D MAX_NUMNODES) check, which will crash if
> passed NUMA_NO_NODE.
>
> Could the commit message be updated to clarify that alloc_pages_node()
> is the API that safely handles NUMA_NO_NODE?
