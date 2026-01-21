Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FDC3644C4;
	Wed, 21 Jan 2026 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006400; cv=none; b=GD4ZBFaIDprhs46Re9SOcQ3TTQKKd4v/sD823os5cwh+CRu1n7BvRTlWOtzVQepavppl48uKlHUkVn2fReliE5N0zuwgi3A8bEHguFxkaTQBCJs4poCeGjxozINq+xrniZCXNSWlSJpm3FRXuiLY+8KZUhKMi+yjBF+fiHuEjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006400; c=relaxed/simple;
	bh=Vt4vSxHdad38y05njobYmzZryjad+VoGMcXRr3TFnn4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=g2hEP8+TWWgHGUhoJL+jaU2MaVJlOrTlWOOxpFKuAg0FLhCDzcP/OdwhOm3E0pqRyq0C9pjvdeoeNxVRvidNZodSLLD7O/fR1izi/Qag9wxYUbZusxqIy1pVjkPmWhW7emrIf1Sc7/ovc83lv8Kk1sflagoG+K5XbSO+xr2l7a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1viZNE-001cD0-0N;
	Wed, 21 Jan 2026 14:39:54 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1viZNB-00000001OTl-3Acx;
	Wed, 21 Jan 2026 15:39:53 +0100
Message-ID: <fe9a24d2b872878e6bf041f02e6ffe1e3570955a.camel@decadent.org.uk>
Subject: [5.10] net/sched: act_ife: convert comma to semicolon
From: Ben Hutchings <ben@decadent.org.uk>
To: stable <stable@vger.kernel.org>
Cc: Chen Ni <nichen@iscas.ac.cn>, linux-rt-devel@lists.linux.dev
Date: Wed, 21 Jan 2026 15:39:49 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-vCLvawXUllRrsoV5v6e2"
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-vCLvawXUllRrsoV5v6e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello stable maintainers,

There has been a build regression for the 5.10 stable branch when both
CONFIG_NET_ACT_IFE and CONFIG_PREEMPT_RT are enabled.  This was
introduced by the backport of commit ce50039be49e ("net: sched: act_ife:
initialize struct tc_ife to fix KMSAN kernel-infoleak") in 5.10.247.

After that change, tcf_ife_dump() includes the single statement:

        opt.index =3D ife->tcf_index,
        opt.refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
        opt.bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
=20
        spin_lock_bh(&ife->tcf_lock);

But with CONFIG_PREEMPT_RT enabled, spin_lock_bh() is a macro whose
expansion starts with "do", so this is a syntax error.

For 5.15-rt and newer, spin_lock_bh() is a function, and 5.4 is EOL, so
only 5.10 is affected.

Please cherry-pick commit 205305c028ad ("net/sched: act_ife: convert
comma to semicolon") to fix this for 5.10.  It should be harmless to
apply to later branches as well, of course.

Ben.

--=20
Ben Hutchings
I'm always amazed by the number of people who take up solipsism because
they heard someone else explain it. - E*Borg on alt.fan.pratchett

--=-vCLvawXUllRrsoV5v6e2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmlw5TUACgkQ57/I7JWG
EQnAlQ//SL47NQysKtUFnSPKuZPuIScVpu/J7X83SP/tgNOAKEGJhVIhp6A1xFFU
Tx0ql82EILb7i8vguOI4E98yUhcgZMEv25kv86FqHmSPl1RKQI3vhGiEX88U94Ho
c3Fqna3S0ErnzMwhUbAk+Vqr150fTxHGJmfCkoEYTx4iwY84fUB2OHYW/ZTWSNJg
VuJUXlD2cq3gFf+0UxXvqdg3fNmvwXi7FP4F9+zVfx/Ofn2u8+lLoepmUUantrEz
nPcPcN3GuHdHhLYpzAadr2JQjo4zNIXk0VEaFikoAHEbBeLa/E1vpZh1JDqzGUDY
pVzZFgSxlG6QDiIdDH0yIbddJr1BKfKqgaQwF5EqZ3bt0gTOSVbU0bCmm3I8+iit
vvEOvnCH8ftkD9tE+PM2bcJkUmOBuzcu4/Jobq9es33XJ7RTITmsg2XJ34Z5xSop
/zCTAn61kQXG3twb0oDufZYGuw+XQMXXuxXxdlR4EIk3ElvFxxi42PQb5YklQCsO
1IKMx6iJi9bnFjbq2kIQyxLVFnVVXZZ49i9zsm83TOMkZQmD+wRSzir5hYDABIij
S1YDUYMByaOoQKiaseX22VLL/+nSsFyhrKtLX0QmWaiOdGI1kPEXHslQ55ZJwm76
2D1lPLMA0WsirhaidQOIxYhPntDMNIQC0NSIbuVthDjDv3Plz2E=
=/twP
-----END PGP SIGNATURE-----

--=-vCLvawXUllRrsoV5v6e2--
