Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8822231CA3
	for <linux-rt-devel@lists.linux.dev>; Sat,  5 Oct 2024 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728118847; cv=none; b=hxFlo4SgVUONeli/aUb/YiEIjfb8pkyvlC3T/DQcAdAdUFxcT885+7M5CZsP/BP0tQyE65Kazvg4LF8noh4yiNdiEBNo0JIjedsEBXRfTaa0+Yl55LGB4DHvKUv3zWPI0pvVUR47wHsTpwdrm+06gSAO99ErBqk0Jtr1B0aZY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728118847; c=relaxed/simple;
	bh=i+Hl2jkW0Y80sNTYZ+yeU/B1CMw0zF82pmSdZ8KEpgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjcllwv1PgQpCZSL0fHlMMZnXstuYCzWa1JCCz7LEox/NzOL4F2u1I91VszmoWzrZa2Er2DYzuZf6dynwbv+cjlD/uzThPgWfbE/z8RppyAPh2v9KLEunsUYjsz3H9oeMGY7p+kvpzq9uU+RsPkIItSFNAn0HYNzFLw34fSkn1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=CU5xOHno; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="CU5xOHno"
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2CDA01C0082; Sat,  5 Oct 2024 11:00:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1728118844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVW3O9XSyifx9yjtLAWEuzOWnRs2kMMJwhsGLsus/PI=;
	b=CU5xOHno9A7mxa95u6GPpq1aZX/t93QGzYQy2ub/3r53f96yzeeTl6kXt4Qr7dyVT6P5dw
	ljRluz90oGLXT+kj2mIbVMV2fAxwkLRmdQweu9UTzsxEBTZLaRkjnRa9dCa0GgvnR8R591
	+pLZ178UFwWogdxOi+KdrMoPqV3tpog=
Date: Sat, 5 Oct 2024 11:00:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] MAINTAINERS: Add an entry for PREEMPT_RT.
Message-ID: <ZwEAO75epgLQ5YZg@duo.ucw.cz>
References: <20241002154639.89wWS_OU@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mhN1KJmQKV9ebzzT"
Content-Disposition: inline
In-Reply-To: <20241002154639.89wWS_OU@linutronix.de>


--mhN1KJmQKV9ebzzT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add a maintainers entry now that the PREEMPT_RT bits are merged. Steven
> volunteered and asked for the list.
> There are no files associated with this entry since it is spread over
> the kernel. It serves as entry for people knowing what they look for.
> There is a keyword added so if PREEMPT_RT is mentioned somewhere, then
> the entry will be picked up.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Pavel Machek <pavel@denx.de>

I wonder how this should be merged. Send it directly to Linus? Make it
part of next rt patchset?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--mhN1KJmQKV9ebzzT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwEAOwAKCRAw5/Bqldv6
8swaAJ0aBekp7Vbvwciq7Sv8VxbJChB4RACghCP0GEieBsd+abOH76w/Y4Cshbw=
=kz72
-----END PGP SIGNATURE-----

--mhN1KJmQKV9ebzzT--
