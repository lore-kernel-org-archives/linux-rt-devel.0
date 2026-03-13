Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0302A218ACC
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Mar 2026 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423200; cv=none; b=NjuFVBK+vWqXs7Px8iMGwzECnyRfVF/qAKhL6/6jiUtULyfs2qY09OWOvGpC1aalmqYQcDwLDM5b6tM9ultK0JBnkZMsPXAEkEaoEGGOCqGwvRtR2lsenjDfGbGMm/HIHTZKK60aSFrimKIAhY1ObhknuGAK83QJFGGYNciGfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423200; c=relaxed/simple;
	bh=1FvDrns+VIGibt6LZ2i1UDMFhT9gPnHDIu+JbLlvxuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYyoEnV4AnNjByJQyZ89USLfGt4CWj/bNcpiM2kzq3l7MWNNgXjQDmxPOxT6LDbKJDHtF7sF11OkMFo35tPrfgpHDR4aW96pAKnxj2LwpTbPd3yEyv+++KKZ8pa2CJ6pJ9DlvwIAscwHIMkp3FRKT8o8U8riWucN/apAc+trRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XnvHsOG+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XnvHsOG+"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so2748155f8f.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 13 Mar 2026 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773423196; x=1774027996; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJae3vdCXODBTLWKk6GJMYHIzIpo0Y/QKoeFPWW1RnQ=;
        b=XnvHsOG+NYonTw6PfktEO2NRe6UCU7dPU0uTfZUh9+lR8T/rKp5Vb0A0quAr320lQO
         oQYHZZEPjhU/qcPMN6Zbn2/kan3uyHu8eeFj6RRMAtWv50zOMgKMAYYsm1qtYVAZp1sW
         Cv34fg7gvx2T6GU5nWhXSLQKO7JNbdzaSrk8OhxVnA1Ni7EF9GbjLSyuoVNSy3SIYQQe
         9vWuz5nLfle5i7lyuPle0rnl00RNfPAaFE9i6n3g+rSTu0IF33KGhq5IlhdrKV2iqCyO
         rBWzfEdHFUhtdaeUUGTS00j/+znVcoI4gX4IuES+ZAuVwblJfrAQUOmFBA8tmu95Ysrb
         HSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773423196; x=1774027996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJae3vdCXODBTLWKk6GJMYHIzIpo0Y/QKoeFPWW1RnQ=;
        b=Wn/ex7U4bVFiNd4nHk29E7MzdZowCaI4wbJi31RhQYRzLbNCgF9gHofID59kv72mLC
         POCtZvMIVkt7b/oXBo41BAxb0u0lwAWFboN6Kd445i2jImhQJBGBSBQXLwwQ81zctg4s
         Kaqedb81dw8OroZcAQ1B/DxTGnQBdP/bsMFsuxchzkc+j1u9zdtC8BdKGVI92OurYKdh
         5IwlVrozLOSfi2zGJWuRq7ZF5PnMRV7kvZi/3hztyBFQsHVFZNGxWfMX8mAP62Je5MtR
         kPf4tLkJAPIspRiteqOCSvbojTAHxXH7usGRk5/b2nJ1h7zlmf6RaEa6Y0PKtyw0Ydy8
         kzvg==
X-Forwarded-Encrypted: i=1; AJvYcCUa9MNT+AG1tRCPh+OZHZrpB+exj6sqn1KQuzj5OzZSotcN1gHeYIbUGqJqOYpbr+oDyL9lG1VN6GJCWQDLJA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwALCmjaNoxwgoJ5TuiL5NQxaxbgjLJCSkstZce430MCPpI4GYW
	UWeJ73A2hS+qQGxXen22pH6ysTDx0SJ0DmqLID1RUOVA48mUgHQnEspQ5ehMIOV8Lqw=
X-Gm-Gg: ATEYQzzTZIdikzTQUQtC46JRpRBCjsFXTlONJ/gYaBqxx/5AnmcI1D30tNeJYP4dCez
	p0/SLWzHmm0oVkYNJZgVP7rWzttPzHh1viFe+JeQCwC00jYIZE+KmpsOTrtGlRPMsDJOdeU4VoO
	Nz+IyPXlIN20D+wjuGr3MASZW4/BTmwP7u1OZvAnjpa9FVA30yNvut+le8i5Y4i4hU4FZZ/J4m9
	44hIVWEn1PJnfQSbt6JdWS9PfsDlA+CVJqsuDiZWkEiArx4upchCAZhgoxMmHIbysTiL8hQtM0f
	+GPw5vzBMK8Kj8lPu1xH7nfHrisy9E8yIq+aBVU9ooJ3Qxda2RXg+4gAxzPAZ+zcASKhu3++EvX
	qG1E8dTRIr0wx32Jz+RIqSBkGGJ0QComPGADqfFiNcOApNwZTDB+RiuEd40JIcepHbinEKyOqb1
	13HMGu8sTyj0OSHmtA3GLdUJOvm/pYwWB0QusK2FY95SjC+77EVIltsw==
X-Received: by 2002:a05:6000:1787:b0:439:c677:5145 with SMTP id ffacd0b85a97d-43a04d880e8mr8009601f8f.22.1773423196103;
        Fri, 13 Mar 2026 10:33:16 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a03cfd18fsm10687099f8f.36.2026.03.13.10.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 10:33:15 -0700 (PDT)
Date: Fri, 13 Mar 2026 18:33:14 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Ben Segall <bsegall@google.com>, Clark Williams <clrkwllms@kernel.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] cgroup: Move cgroup_task_dead() to task_struct clean up
Message-ID: <ydymxaffr2s7npif37msq5q467m2ql26ib6wifwoztuhqmg4ao@id5c532lhorb>
References: <20260311120829.rEHY-xh9@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="icf7bhdyxkpgumzx"
Content-Disposition: inline
In-Reply-To: <20260311120829.rEHY-xh9@linutronix.de>


--icf7bhdyxkpgumzx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup: Move cgroup_task_dead() to task_struct clean up
MIME-Version: 1.0

Hello.

On Wed, Mar 11, 2026 at 01:08:29PM +0100, Sebastian Andrzej Siewior <bigeas=
y@linutronix.de> wrote:
> @@ -7084,6 +7031,7 @@ void cgroup_task_free(struct task_struct *task)
>  {
>  	struct css_set *cset =3D task_css_set(task);
> =20
> +	cgroup_task_dead(task);
>  	if (!list_empty(&task->cg_list)) {
>  		spin_lock_irq(&css_set_lock);
>  		css_set_skip_task_iters(task_css_set(task), task);

Erm, isn't this way too late?
I see that cset->dying_tasks is appended in do_cgroup_task_dead() (which
I was used to find in cgroup_exit()).

(Also, whole cgroup_task_dead() becomes single use thing so it could be
open-coded in the place where it belongs.)

Thanks,
Michal

--icf7bhdyxkpgumzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCabRKUxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhC+wD6AwoXxqDMnAvLA0fFaR3n
RBbBzz+2eCAG2EiT+fz0vMwBAPJW2izPg9m5qc1JgR/a4wkmjgFaAPU3uckGFNu8
R/IP
=fA8G
-----END PGP SIGNATURE-----

--icf7bhdyxkpgumzx--
