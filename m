Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB39A425CFA;
	Mon, 29 Jun 2026 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782745447; cv=none; b=g5JcgJsLlBnbSgWfeqA7ubXU84QTHpah+9841P5+U+qRwM6lewByrTDrFn+bo/tSiyjzj7zQCQd8gTQVBJHO4uBA3KafcPYkAJ3pD52mlsy2URe3Bi3gB44gOT4HSqKX/n9npUo4WI7Ao7zwrShLX3ADafK1VJWTfgT/1V6pgXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782745447; c=relaxed/simple;
	bh=pLaLuL2FRfGnbjCIgDu+dK9URJVU5PuWlIyc8ZkzGes=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rNGhc2iWbc8KShIi4KNNDyYcYP/GVZsAWFGqIB6G8zdmogLy2Eo5/RcKJWIv9jA1mFrVDNC57surZjUeqlC9xsi/5YGrQ533heETtBY0Papk2h/F1+HroIR+XlABwvHWmkekGMfDUIpyJRqr5rMtf+7kmde9hVggKTNDIF+BOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7wWkk3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7wWkk3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC70F1F00A3A;
	Mon, 29 Jun 2026 15:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782745446;
	bh=/m9+2Uy2wlsNBz4xOfeoMZTUA0uoJ1w3fsOAE0MjsGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R7wWkk3Gzx+zoqK/RBb83VnWqdjgdGDHlZO7WDEExJF0fxTZV+U2KPqa7KBZZ9MVS
	 bMOLsYyWBKb71eF9fiW1/AQEEam4TK0wvOEAvF7uIes10Z6Z8ir36Y0ng9BSmIfiS8
	 sCREl32g1/DP6pW0aug02isjsXp9XvwSRg6JvvGj0YKHYaxTaL7Wv+SrYEF1LrDbdS
	 3HX8UG0TCE2+ggJS+3HbllL8c+ETXMplXMS1yqLOUWG9nDdQKKeVOhzQD3Vik4keeg
	 ck0FyKsdCkfTPV35eSonqhYX9Pggok1TVhS26HWJOq/m/HLSIDPvkuwl/12CIUS8IE
	 Hx1Gf8DpSzLuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/16] sgi-xp: Use higher-level allocator API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260629-alloc-trylock-v3-11-57bef0eadbc2@google.com>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-11-57bef0eadbc2@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 15:04:05 +0000
Message-Id: <20260629150405.EC70F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] xpc_init_mq_node() incorrectly passes the node ID (nid) instead of=
 the loop variable (cpu) to xpc_create_gru_mq_uv().
--

commit 364bc05827d5201ce117b2c0d83f21a9b64f85f3
Author: Brendan Jackman <jackmanb@google.com>

sgi-xp: Use higher-level allocator API

This commit replaces __alloc_pages_node() with alloc_pages_node() in
xpc_create_gru_mq_uv(). The __alloc_pages_node() function is being phased
out, and alloc_pages_node() works identically here while allowing
NUMA_NO_NODE if it were needed.

> diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
> index 772c787268932..aacff70204241 100644
> --- a/drivers/misc/sgi-xp/xpc_uv.c
> +++ b/drivers/misc/sgi-xp/xpc_uv.c
> @@ -170,7 +170,7 @@ xpc_create_gru_mq_uv(unsigned int mq_size, int cpu, c=
har *irq_name,
>  	mq->mmr_blade =3D uv_cpu_to_blade_id(cpu);
> =20
>  	nid =3D cpu_to_node(cpu);

[Severity: High]
This is a pre-existing issue, but while reviewing this code, I noticed a
potential out-of-bounds access issue.

In xpc_init_mq_node(), the node ID (nid) is incorrectly passed instead of t=
he
loop variable (cpu) to xpc_create_gru_mq_uv():

drivers/misc/sgi-xp/xpc_uv.c:xpc_init_mq_node() {
    ...
		xpc_activate_mq_uv =3D
			xpc_create_gru_mq_uv(XPC_ACTIVATE_MQ_SIZE_UV, nid,
					     XPC_ACTIVATE_IRQ_NAME,
					     xpc_handle_activate_IRQ_uv);
    ...
}

Because xpc_create_gru_mq_uv() expects a valid CPU index, passing a NUMA no=
de
ID means the cpu parameter here contains a node ID. Since NUMA node IDs and
CPU IDs are in different ID spaces, cpu_to_node() will access the numa_node
per-CPU variable using a node ID instead of a CPU ID.

If the node ID is greater than or equal to nr_cpu_ids, will this result in =
an
out-of-bounds access causing a kernel panic during module load?

Even if it is within bounds, does this result in routing interrupts and
allocating memory using the topology of the wrong CPU?

> -	page =3D __alloc_pages_node(nid,
> +	page =3D alloc_pages_node(nid,
>  				      GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
>  				      pg_order);
>  	if (page =3D=3D NULL) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-alloc-tryl=
ock-v3-0-57bef0eadbc2@google.com?part=3D11
