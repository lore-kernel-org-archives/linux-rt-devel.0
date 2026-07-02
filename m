Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CD73C2BBA;
	Thu,  2 Jul 2026 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989665; cv=none; b=CAnOe4iGqHKwHvSyz0U5SJAllTRHOoCQoTYyo/GekBquTVxBsEks1IS+2DN8DEXPjdiEEvSMimUeyoVIWbYHvVYAt7CqE5DKcWL02nUX+70xldjMShqOq4tRIInWnU+HTdZQVaBGl52VQMjac0KK01QATfh7hJCv6PIRAVaPHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989665; c=relaxed/simple;
	bh=A2/242rXmlm5K3Y4paFxJikS1rvg0sOrX9keXLrpgNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o6UEIAxJsKlF28Ie7un1CFANzLHRZq0zQRzFMRaK/sd43CaCkFXm7HyaZU3M7XDlFhPRw0of36E7hFP1othEz5tTJjzYBJSxJ8EbnO+/FqQ2LllUlSbt3jNbGZfb9sPg3coXlV3+KEgOK7ev9BZXp4wZDZ7delSXzeBxxnVrVto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+Fr1dU4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+Fr1dU4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA511F000E9;
	Thu,  2 Jul 2026 10:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782989664;
	bh=mVUAukW7kk22htjRVsRwj4HKa88LF55VHb4DAWe3D94=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U+Fr1dU469MWU5A0liW1WjZxL9y8EJxZjXhnIQRQjxCnGrjd3nDTUsV1ejIP5mkzw
	 0soJqXM9HFem9F5pBYCwOz55narj7WO6eWDfRWV0yYZaoucPQf0JGuSvn/YbiuLLe6
	 F/Ics/OnFbh2BejqtnYWacEGw7L9paDE390GN1ji/N8WWuYpLehCq09XscFzraWpkO
	 4bUJbgLFxWJsDjElpNk8kBSrAj67/5eXWM8OVh6m9sSRWnUKL7lKTGck7e4SKvSlvq
	 l+jtbxAHmHbbfXInQxw87jlvFeb9GCPRx4djsAHCrtmVKFgLx5G7p7GLvZ36SmwsOw
	 +K8dqKzDLHsWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/18] sgi-xp: Use higher-level allocator API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brendan Jackman" <jackmanb@google.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260702-alloc-trylock-v4-11-0af8ff387e80@google.com>
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
 <20260702-alloc-trylock-v4-11-0af8ff387e80@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 10:54:22 +0000
Message-Id: <20260702105423.BAA511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] xpc_init_mq_node() incorrectly passes a NUMA node ID (nid) in plac=
e of a CPU ID to xpc_create_gru_mq_uv().
- [High] xpc_init_mq_node() fails to catch empty CPU masks, leaving global =
MQ pointers NULL and reporting false success.
--

commit 4df0c24c50fd7156f7d0c39d45d908827e5063f5
Author: Brendan Jackman <jackmanb@google.com>

sgi-xp: Use higher-level allocator API

This patch updates the memory allocation in xpc_create_gru_mq_uv() by
replacing __alloc_pages_node() with alloc_pages_node(). It aligns with
the deprecation of the former while preserving the existing NUMA-aware
memory allocation behavior.

> diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
> index 772c787268932..79c2f00ed4d70 100644
> --- a/drivers/misc/sgi-xp/xpc_uv.c
> +++ b/drivers/misc/sgi-xp/xpc_uv.c
[ ... ]
> @@ -170,9 +170,8 @@ xpc_create_gru_mq_uv(unsigned int mq_size, int cpu, c=
har *irq_name,
>  	mq->mmr_blade =3D uv_cpu_to_blade_id(cpu);
> =20
>  	nid =3D cpu_to_node(cpu);
> -	page =3D __alloc_pages_node(nid,
> -				      GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
> -				      pg_order);
> +	page =3D alloc_pages_node(nid, GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
> +				pg_order);

[Severity: High]
This isn't a bug introduced by this patch, but looking at how this function
is called from xpc_init_mq_node(), is the correct CPU being passed in?

drivers/misc/sgi-xp/xpc_uv.c:xpc_init_mq_node() {
	for_each_cpu(cpu, cpumask_of_node(nid)) {
		xpc_activate_mq_uv =3D
			xpc_create_gru_mq_uv(XPC_ACTIVATE_MQ_SIZE_UV, nid,
					     XPC_ACTIVATE_IRQ_NAME,
					     xpc_handle_activate_IRQ_uv);
        ...

It appears the loop invariant nid is passed as the cpu argument instead of
the cpu variable. Could this cause the message queue to be initialized
using the wrong physical topology resources, scrambling routing and IRQ
configuration since xpc_create_gru_mq_uv() uses the provided cpu argument f=
or
uv_cpu_to_blade_id(), cpu_to_node(), and xpc_get_gru_mq_irq_uv()?

[Severity: High]
This is also a pre-existing issue, but does xpc_init_mq_node() properly
handle online NUMA nodes with no CPUs?

If the cpumask for the node is empty, the for_each_cpu() loop will not
execute:

drivers/misc/sgi-xp/xpc_uv.c:xpc_init_mq_node() {
	for_each_cpu(cpu, cpumask_of_node(nid)) {
		...
		if (!IS_ERR(xpc_activate_mq_uv))
			break;
	}
	if (IS_ERR(xpc_activate_mq_uv)) {
		cpus_read_unlock();
		return PTR_ERR(xpc_activate_mq_uv);
	}
    ...

Since xpc_activate_mq_uv is initially NULL, IS_ERR(NULL) evaluates to false.
Will this bypass the error check, report false success, and leave the
pointer NULL, leading to a panic when it is dereferenced later in the driver
lifecycle?

>  	if (page =3D=3D NULL) {
>  		dev_err(xpc_part, "xpc_create_gru_mq_uv() failed to alloc %d "

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-alloc-tryl=
ock-v4-0-0af8ff387e80@google.com?part=3D11
