Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9FD1448D5
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Jan 2026 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176224; cv=none; b=RSW8KGtJJplEG3U5GLQeb9uxeyzPrDF7HFWF0A6k5TUMY/R68JTfMoBqFp8cqT2HZs3JEjakGw0N4v7Q5yNtNkczyY3rPigkm9WTVOY7Z8Gn5lNl290w6y4juRaLR/BNepfth54oFnuD6Wjq4XBNQPsw560/VuMgRHrIZXLmwKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176224; c=relaxed/simple;
	bh=oHABnvfXBlVrftVJekZ578HCsQh3TGBXWbJyWOV27ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xph/kGQkRLZg8itbyVxiHzt5mx4u251RW7zOMBhvZHauD64hGlDkGpTYyAft3cI9kHk8QiKB7Y2l36R1MbFX08d2DaUKCXoYn5kf6IsLNOWXZHU10yJkNcMJ6uCg9I0ghbQe+Y8gcQUpwllM+S1tO1c2pNAOxmJmsxNY+DVVkBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUwYeBYJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUwYeBYJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769176222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1WONNtqCu6LKQf22ZJpLLTIem2aa8W5Gfqm0AALqkZo=;
	b=JUwYeBYJuTIWosaf8UqaVvBo1aDPFkB0uHuTqI9R3mY6iQ8btXBTCUBxkJ+B3Lu8to8WR+
	pN4C/KnuX2a0XmC/rV8JzqM6tvJaNuRfvibN7JrKyv/fvz/B2jWEPU382oExKh4SpEm+Yl
	x3HQzTZnuLnU+QqnGoqhyortb7+IdtQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-YvBjDA30Or6Fq5CVuYWgMA-1; Fri,
 23 Jan 2026 08:50:18 -0500
X-MC-Unique: YvBjDA30Or6Fq5CVuYWgMA-1
X-Mimecast-MFC-AGG-ID: YvBjDA30Or6Fq5CVuYWgMA_1769176217
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F07119775AA;
	Fri, 23 Jan 2026 13:50:16 +0000 (UTC)
Received: from localhost (unknown [10.22.89.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8811A1801AC9;
	Fri, 23 Jan 2026 13:50:15 +0000 (UTC)
Date: Fri, 23 Jan 2026 10:50:14 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable <stable@vger.kernel.org>, Chen Ni <nichen@iscas.ac.cn>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [5.10] net/sched: act_ife: convert comma to semicolon
Message-ID: <aXN8ltBrBMuLmj-s@redhat.com>
References: <fe9a24d2b872878e6bf041f02e6ffe1e3570955a.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1og4atT/0XttzaxX"
Content-Disposition: inline
In-Reply-To: <fe9a24d2b872878e6bf041f02e6ffe1e3570955a.camel@decadent.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


--1og4atT/0XttzaxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 03:39:49PM +0100, Ben Hutchings wrote:
> Hello stable maintainers,
>=20
> There has been a build regression for the 5.10 stable branch when both
> CONFIG_NET_ACT_IFE and CONFIG_PREEMPT_RT are enabled.  This was
> introduced by the backport of commit ce50039be49e ("net: sched: act_ife:
> initialize struct tc_ife to fix KMSAN kernel-infoleak") in 5.10.247.
>=20
> After that change, tcf_ife_dump() includes the single statement:
>=20
>         opt.index =3D ife->tcf_index,
>         opt.refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
>         opt.bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> =20
>         spin_lock_bh(&ife->tcf_lock);
>=20
> But with CONFIG_PREEMPT_RT enabled, spin_lock_bh() is a macro whose
> expansion starts with "do", so this is a syntax error.

Ben, we had two other instances where the v5.10-rt implementation of
spin_lock_bh() as a macro required touching the code to fix build problems:

    386242acb15e rt: fix build issue in at_hdmac
    72bf92dcdcab rt: fix build issue in be2net

As there were only two instances, it made no sense at the time backporting
the RT locking implementation from v5.15-rt or newer.

I can cherry-pick the commit you mentioned to v5.10-rt and carry it until
it hits stable. I will also discuss with the maintainers for stable RT
whether it is a good idea or not to update the locking code of v5.10-rt
(EOL in Dec 2026) or not.

Thank you again for spotting this build problem!

Luis

> For 5.15-rt and newer, spin_lock_bh() is a function, and 5.4 is EOL, so
> only 5.10 is affected.
>=20
> Please cherry-pick commit 205305c028ad ("net/sched: act_ife: convert
> comma to semicolon") to fix this for 5.10.  It should be harmless to
> apply to later branches as well, of course.
>=20
> Ben.
>=20
> --=20
> Ben Hutchings
> I'm always amazed by the number of people who take up solipsism because
> they heard someone else explain it. - E*Borg on alt.fan.pratchett


---end quoted text---

--1og4atT/0XttzaxX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEk1QGSZlyjTHUZNFA85SkI/jmfCYFAmlzfJUACgkQ85SkI/jm
fCb9xA//Qgc5Hh8KawRsZp4yknRQLPYvNK7Yp3hnnwiTpHRKs0yESGgitwWfyePt
Il9CK8WCzLmSz/OM2Cc4ZGAbBl/sexCvv7LmXxp60lxsgbOE2LCFlPZNfcIagxY9
dKLh015qw6Epj1SeDryH5BMDaDJhwIEnG6CNJCgt8jOG/xpVhfVfO4gyc0kOXxZm
ay/coNiHUZOWmY2jwzVw6NDycsVkfGPLVxupyoeZlxNATvIsDnM13FsyELXgi+1k
PyvDR/eMTALqL7HUyk8d5UMOoXZM2pG8dmAI5Njz6hwTrorubG4cA2f9xAS9VkWr
IgsFz5/+Li/SeNhhwjCystTA8cO6uP8MSPE7rMZwoMzIEdplKF8EBuqAkbhunpbi
vamlg6WOmP1g3adDtI1gQgOsixJIKu83QTl2bS8o6QmLYIeZFsNxwK47chkjp+sX
NpAyegHyI3wdDdBgLGfz4IW9WoyQybREJIXvihV5X1ZpaTyjX4oX/QSLYqi5ixMN
V3AxAX1wU0PtVcwqzWQj+pgLoucPDLWJKaxEQBtftFRFFRn3lj7ohaHuKVHpBm0e
vma03MCCqoYMrft0O+7cYbRUL1SWrHs7WX4i9ZjShm0zweW3Dx8noP34c4dUS8Qi
6syHYd33voN5E/Savfx4Pvx7twlgCv7BurnsTxfuLXDyXe1+fpg=
=drRa
-----END PGP SIGNATURE-----

--1og4atT/0XttzaxX--

