Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C3419F40B;
	Mon, 22 Jun 2026 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123325; cv=none; b=i0KpxXKUGl5OKy1fPKWKK9WgQPcQuz/O56k9qxESx/bwBvY0NKsLoZleYXGQLZ8AO0BU9sTXqzwJELB617RIHR4QRU62s1JFfcpMhbOs7QfDLuBOs114GABHwe8fqfhfiw5s5MrDXxAR2Do8OF2nkdedFKLp6HkfR0JlOf9n+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123325; c=relaxed/simple;
	bh=V5WW7uwKx60c61QqdLve/PD7p7tT/vp40/AV5krN/nU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A9l9IQ4WK6uYgMhgQKk0Rwm5wZv9mJNKFmBWA5XEmG6GoRj6o4UNjXzrmLKk/hq+DfhWIJBlmpJRtCmf2JMZEqghCKSOPflNmXbVYKsPQgkbACTWQIlECwSHjXFdUQbezsJUk+0s36LB+9h6HCH0Ba+/tlucCVA7RMuc+ujzw9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8mHLmZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8mHLmZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FDE1F000E9;
	Mon, 22 Jun 2026 10:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782123324;
	bh=GTJirt03i6IuV2yU2Lrcvoje4e/Zn2Jxie1ncDOP9Ss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P8mHLmZhjudIDw6o4J3zsOu4yTNCYM6/w3H/My5oxrSyXw0IBLBt+IRSdxNEmZvNG
	 6JguvSWJ2/nGho/jirrMbrRBWT4FBwcNriBc0bkDyBYSu7yKAqC8nnUiHUF61wgnmx
	 +VWBvUYdFfu+EkZa83eHZrBSCa3HbcXbfiIbnqh707ga4Maht6Z2LaWfOYccD8hfAG
	 edY86uy6kuHGzp2du6cH0c15LSM80dBkINaiToRBpX3ViL4LF9VaaTpj/edE29HEQX
	 DQ2MHHF5gtIq8A1NkK9OAGrDr4KJBxvI8SAsXjihRbRnBcKaOfOA4aUNjJaNeE8wLb
	 aZU0SvBeZIXwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/13] sgi-xp: Use higher-level allocator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260622-alloc-trylock-v2-8-31f31367d420@google.com>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-8-31f31367d420@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 10:15:23 +0000
Message-Id: <20260622101524.40FDE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Commit message fundamentally misunderstands and inverts the docu=
mented differences between __alloc_pages_node() and alloc_pages_node().

Pre-existing issues:
- [High] Logic Error / Variable Mismatch in xpc_init_mq_node() breaks CPU f=
allback and NUMA affinity.
- [High] Hardware IRQ enabled before GRU message queue descriptors are full=
y initialized leads to NULL pointer dereference on spurious interrupts.
--

commit 2717112c630ddd5adcf0324575c2741c6d3bf969
Author: Brendan Jackman <jackmanb@google.com>

sgi-xp: Use higher-level allocator

This commit switches xpc_create_gru_mq_uv() to use alloc_pages_node() inste=
ad
of __alloc_pages_node(). The change is intended to replace an allocator
function that is being removed with one that handles similar requirements.

> sgi-xp: Use higher-level allocator
>=20
> The difference between __alloc_pages_node() and alloc_pages_node() is
> that the former allows you to pass NUMA_NO_NODE.
>=20
> The former is going away and the latter works fine here so switch over.

[Severity: Medium]
Is this description accurate?

__alloc_pages_node() strictly prohibits NUMA_NO_NODE, while
alloc_pages_node() safely handles it by falling back to numa_mem_id().

While the code change itself appears safe here since cpu_to_node() returns
a valid node, could the commit message be updated to reflect the correct
behavior of these memory allocation APIs?

> diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
> index 772c787268932..aacff70204241 100644
> --- a/drivers/misc/sgi-xp/xpc_uv.c
> +++ b/drivers/misc/sgi-xp/xpc_uv.c
> @@ -170,7 +170,7 @@ xpc_create_gru_mq_uv(unsigned int mq_size, int cpu, c=
har *irq_name,
>  	mq->mmr_blade =3D uv_cpu_to_blade_id(cpu);
> =20
>  	nid =3D cpu_to_node(cpu);
> -	page =3D __alloc_pages_node(nid,
> +	page =3D alloc_pages_node(nid,
>  				      GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
>  				      pg_order);

[Severity: High]
This isn't a bug introduced by this patch, but looking at the interrupt set=
up
that occurs further down in xpc_create_gru_mq_uv():

drivers/misc/sgi-xp/xpc_uv.c:xpc_create_gru_mq_uv() {
    ...
    ret =3D request_irq(mq->irq, irq_handler, 0, irq_name, NULL);
    ...
}

If a spurious interrupt occurs immediately after request_irq() is called,
could xpc_handle_activate_IRQ_uv() dereference the global xpc_activate_mq_uv
pointer before it is initialized?

drivers/misc/sgi-xp/xpc_uv.c:xpc_handle_activate_IRQ_uv() {
    ...
    msg_hdr =3D gru_get_next_message(xpc_activate_mq_uv->gru_mq_desc);
    ...
}

The global pointer doesn't seem to be assigned until xpc_create_gru_mq_uv()
returns to its caller.

[Severity: High]
This is a pre-existing issue, but looking at xpc_init_mq_node() which calls
xpc_create_gru_mq_uv():

drivers/misc/sgi-xp/xpc_uv.c:xpc_init_mq_node() {
    ...
    for_each_cpu(cpu, cpumask_of_node(nid)) {
        xpc_activate_mq_uv =3D
            xpc_create_gru_mq_uv(XPC_ACTIVATE_MQ_SIZE_UV, nid,
    ...
}

Does this loop inadvertently pass the nid variable instead of the cpu varia=
ble
to xpc_create_gru_mq_uv()?

This appears to bypass the CPU fallback iteration and could result in
querying uv_cpu_to_blade_id() and cpu_to_node() with a node index rather
than a CPU index.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-alloc-tryl=
ock-v2-0-31f31367d420@google.com?part=3D8
