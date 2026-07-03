Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B182184540;
	Fri,  3 Jul 2026 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082930; cv=none; b=fHPpS2RUuNP8hxSH/lqCe/qzg8g6Nzsb5CBbM6g1ICvU75rnhJ5wIi7zotSdsi8IM2mkJ4ATyeAwUcGat9FHdY+/gYY/GuYWpiW/MtRDRu13+N4tb4dzsqJhG6QFLK2kqKb4ptyF+Ufft1UUtV2o3rHCZfKt1x+3YzP5Q0qNA+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082930; c=relaxed/simple;
	bh=0XOXUQrZbUOYbOhdH+lTViBuZkdAmzuPWvRDdZKYwIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R7pHW8q/VLAMlf3gwpT1YnXyL6Ke4iQvAmdpioBYKZqBfWelv2+lo+ddu+YPN/5+fqPonxMSzQonuBg3qtZk19Qf0+NCQdcOjQC5CbtOgK6TfqXbKdcC8yo2kF1xsWbdpMGZKib+qY9FnS0CGZg2Irllp2673SOKw58QBg4Z1SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVXfVcac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVXfVcac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CBA1F000E9;
	Fri,  3 Jul 2026 12:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783082928;
	bh=zI2R5ZACemsvCeBAHaTDpoc0Kx2ukXsDUdu7ni1UFHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gVXfVcac3n/FqEiEc9wkTedvORhmItLNipLFxdAwqpeN6cJqoQYElH1W3asNvcsrB
	 IJrn3WU4WOBu5b4y2djmksvrT9F6PSkSVeQy4uFLRxNnQzXI9lUE8YLNrZ2C/A0a0D
	 HqwwxETWR7JPmv5tc+I44SMpM7vk6PaHIXRpLs6ILsnmcb+t4MlxKqNET9mv947BPe
	 2cTRhoG9qpNHhsdGAtvz5LEUnOW020cnc+cFaDHle3sqewKEMC4RAopHnuVne5Bmfd
	 JCEn4wSrplonD9osZ5BY0fyf8ygoEQPXTIAF22iUbTcuWFAJ9PzVOgqpiGxaZQnOsx
	 2YKhXOL7QOlbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/18] sgi-xp: Use higher-level allocator API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260703-alloc-trylock-v5-11-c87b714e19d3@google.com>
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
 <20260703-alloc-trylock-v5-11-c87b714e19d3@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:48:48 +0000
Message-Id: <20260703124848.96CBA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In `xpc_init_mq_node()`, the loop iterates over CPUs but mistakenl=
y passes the `nid` (node ID) variable to `xpc_create_gru_mq_uv()` instead o=
f the `cpu` iterator.
--

commit 60dc55f94c78f2b8722b9d132aa85a4603393bdd
Author: Brendan Jackman <jackmanb@google.com>

sgi-xp: Use higher-level allocator API

The difference between __alloc_pages_node() and alloc_pages_node() is
that the latter allows you to pass NUMA_NO_NODE.

The former is going away and the latter works fine here so switch over.

No functional change intended.

> diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
> index 772c787268932..79c2f00ed4d70 100644
> --- a/drivers/misc/sgi-xp/xpc_uv.c
> +++ b/drivers/misc/sgi-xp/xpc_uv.c
> @@ -170,9 +170,8 @@ xpc_create_gru_mq_uv(unsigned int mq_size, int cpu, c=
har *irq_name,
>  	mq->mmr_blade =3D uv_cpu_to_blade_id(cpu);
> =20
>  	nid =3D cpu_to_node(cpu);

[Severity: High]
This isn't a bug introduced by this patch, but while looking at how the cpu
argument is handled here in xpc_create_gru_mq_uv(), I noticed an issue in
its caller.

In xpc_init_mq_node():

	for_each_cpu(cpu, cpumask_of_node(nid)) {
		xpc_activate_mq_uv =3D
			xpc_create_gru_mq_uv(XPC_ACTIVATE_MQ_SIZE_UV, nid,
					     XPC_ACTIVATE_IRQ_NAME,
					     xpc_handle_activate_IRQ_uv);

Is it possible that the node ID (nid) is mistakenly passed into
xpc_create_gru_mq_uv() instead of the cpu iterator? This also happens a few
lines later when allocating xpc_notify_mq_uv.

Passing a node ID where a CPU index is expected will cause per-CPU lookups
like uv_cpu_to_blade_id() and cpu_to_node() to access data for the wrong CP=
U.
If the node ID exceeds nr_cpu_ids, this could also cause out of bounds memo=
ry
accesses.

> -	page =3D __alloc_pages_node(nid,
> -				      GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
> -				      pg_order);
> +	page =3D alloc_pages_node(nid, GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
> +				pg_order);
>  	if (page =3D=3D NULL) {
>  		dev_err(xpc_part, "xpc_create_gru_mq_uv() failed to alloc %d "
>  			"bytes of memory on nid=3D%d for GRU mq\n", mq_size, nid);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-alloc-tryl=
ock-v5-0-c87b714e19d3@google.com?part=3D11
