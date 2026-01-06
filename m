Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BA41D7E42
	for <linux-rt-devel@lists.linux.dev>; Tue,  6 Jan 2026 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713258; cv=none; b=nUQR3xacgHwZaSXYL54QTkKcUn8M0+OzvampGU9BK0874qUfkvvinUu3UfWAvsjmgnN3to9Cey3eSHkv1gVk+Hc3XBGssfez6+sNriKd70k9pqYMFTT1xFXSoYN06Av39en4rrlrURuhrt2zbG8uYkD8fH/YgWgUXD3utW0UNJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713258; c=relaxed/simple;
	bh=QX2LtdUErqvD4jZsxkBCFKr82NhjKu96wSqyajbvVkY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n8I0sFFupMq9y0He7EiSfRYRZIlBDc+hfQcOSBRW15adWXO9VBQSwVb7FFlwSGaYqdDIq5ThsKlnEOGsEdnsNvxb09F3/6BGpuVql8fqb4C/IFmbi8k2aFDKRpJC5RQd0d5ydakh6nw+Wf3Mqx2/rmxFVesyNXynsJay6vxJvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=iBu16f3I; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="iBu16f3I"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed66b5abf7so32317891cf.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 06 Jan 2026 07:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1767713255; x=1768318055; darn=lists.linux.dev;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HlyL6ir9rr6kD5Uup2D4ImbUfywS89pe0m/jczEyFK8=;
        b=iBu16f3Iqcfy3dVkcxs8+KBrRAFe5ifpCOD5jcZZIgr9b632aCAlPcEtVnEFDsGULh
         aKce0arpmTokCzUYnxQR8wFEEitkxDaar66+DxBJkS4bkqNs+9Mj6cq6ynlVWXA9FLKr
         CcTLxjX2OuidSkg3xrURa2pCcZ8nb19SJAqwlrKB2rLMJ5adhK7Q7M9WEkAGS2FoY055
         SeGNMelwI0OUwmxqcnYODYQbJ4jXuaWCWSyYMrG34jFLO1iAUv0zbTf0oLFgjRiYg0G0
         IGugaQku1XU7tXHkwuRK6oS9/NwY61PkXeYFXbebraDGjPeaf5kyycqw68S2kVIRRBdR
         UwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713255; x=1768318055;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlyL6ir9rr6kD5Uup2D4ImbUfywS89pe0m/jczEyFK8=;
        b=rC4qmj9rCYVWnMVD1FxJjVgqwNK3t2I93e3dSX/A5UdDG/bvCW9AANSyye74MXFCiZ
         1R9Xzg41wRljt3GLXtFXl5eSzSFVqaBnfz9RmttePCaOXIQkHBOPFNja2GI2uXP7PCFw
         vd+tjLTQILLH6ol6hJ5lMjoRsuPMXXI4tyO/PDJ6krz5qRUXXFyMXjLXWgJwGLrroEFA
         RtGQuuRcBf+8kiqQ6IBXZelcIWlyLGPbljXAk0lQjdmYpftgWF+0AGtz3f/nL7iETxBi
         jZXpX/ziF89UhH5vEXFh0qVXXqbiKAX8KWbxY+3XQ/j2Td2Il9adGD+LstFlhvQ/Ib7t
         92jw==
X-Forwarded-Encrypted: i=1; AJvYcCU8kzF93ZFLmhZhFtaMLnzt7ONSqTTAahghCRcGYCP5ehDwZ+3gTlDLA2gYemBnz/T2G1S5WLvjC7VL2xzvsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhpvvQAzhj6rMdnKaFTwe6qZIeAnafFE/lJGhPgKbK4PxOZt08
	vl1jhy08oO7IvlwYRFjFgV2ohzRPrsev6pQHy6rCAnlzo1Depi+GVw9M9ORDUUaw+Mc=
X-Gm-Gg: AY/fxX6MEj6xLa6OPFD5rxt3OTBdQj8HNsBbkh+n99eIXy/vgEurrV6HFkoQBtdZmwH
	Efe2SC9MOgka9Dy4GGa6MBgbPdFrc9LsnIW8Aw5Q7THgXsoaMMMlUFoIT1xZzP8kfLzN/5Yvy1Q
	rnP6N38bOUmucbUjElVcgRDSEMBo6rHG74I96HlT3ISKQNRQxbVXl4pqCjxae4cfwV4VYhyjxgK
	6cQL7IOrCjmsdEO4Xzkeo8F7eTH1i5up+eEG7AhNPGmOXgSQUs0qfsWgM5LfDvZj6wj6CTfRecy
	JofoMcpFRtW/nvcO7mck/r6jn6SJ4f6T4Cy3m+HZGkC+UuQe0mT2SOwEMNWpV39fJWWhOIH74Zt
	HuaMP8yaSS8TyttsT/1s8Fkrf83R9vwtlJ+1FUPAXR2D/sGywjDZsUl0PVX6jxl52aCjiojHlhu
	xp3W+Mzdu2WKkL8jGNXGOwksYaQLI=
X-Google-Smtp-Source: AGHT+IHybAbF3H+IJN/yvYCsk7W4cWAGrCLZ8GzdP+IKOzhpBxC7YXlvzlqofYK3609iFN8lfn51iQ==
X-Received: by 2002:ac8:59ca:0:b0:4ff:b0f4:c307 with SMTP id d75a77b69052e-4ffb0f4c3b3mr9966711cf.24.1767713254789;
        Tue, 06 Jan 2026 07:27:34 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:7b4b::5ac? ([2606:6d00:17:7b4b::5ac])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d3d92esm13054401cf.5.2026.01.06.07.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:27:34 -0800 (PST)
Message-ID: <542f97c1b2dee066f9961b508958f7397faaaf8f.camel@ndufresne.ca>
Subject: Re: [PATCH 2/4] media: dw100: Implement dynamic vertex map update
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Stefan Klug <stefan.klug@ideasonboard.com>, Laurent Pinchart
	 <laurent.pinchart@ideasonboard.com>
Cc: Xavier Roumegue <xavier.roumegue@oss.nxp.com>, Mauro Carvalho Chehab	
 <mchehab@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Date: Tue, 06 Jan 2026 10:27:31 -0500
In-Reply-To: <176770977089.12184.13455944501335843394@localhost>
References: 
	<20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-0-65af34d04fd8@ideasonboard.com>
	 <20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-2-65af34d04fd8@ideasonboard.com>
	 <f4e0b1f13ee54d88d1035828af548f5cf3a25c16.camel@ndufresne.ca>
	 <20260106004206.GK10026@pendragon.ideasonboard.com>
	 <2dbb2c41422cb4dbc8c3692646aeaf70c4d87df0.camel@ndufresne.ca>
	 <176770977089.12184.13455944501335843394@localhost>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-WOl4j+GsYoelptSN5dqf"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0


--=-WOl4j+GsYoelptSN5dqf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

	Le mardi 06 janvier 2026 =C3=A0 15:29 +0100, Stefan Klug a =C3=A9crit=C2=
=A0:
> Hi,
>=20
> Quoting Nicolas Dufresne (2026-01-06 14:47:59)
> > Hi,
> >=20
> > Le mardi 06 janvier 2026 =C3=A0 02:42 +0200, Laurent Pinchart a =C3=A9c=
rit=C2=A0:
> > > On Mon, Jan 05, 2026 at 01:58:25PM -0500, Nicolas Dufresne wrote:
> > > > Le lundi 05 janvier 2026 =C3=A0 12:35 +0100, Stefan Klug a =C3=A9cr=
it=C2=A0:
> > > > > Implement dynamic vertex map updates by handling the
> > > > > V4L2_CID_DW100_DEWARPING_16x16_VERTEX_MAP control during streamin=
g. This
> > > > > allows to implement features like dynamic zoom, pan, rotate and d=
ewarp.
> > > > >=20
> > > > > To stay compatible with the old version, updates of
> > > > > V4L2_CID_DW100_DEWARPING_16x16_VERTEX_MAP are ignored during stre=
aming
> > > > > when requests are not used. Print a corresponding warning once.
> > > > >=20
> > > > > Signed-off-by: Stefan Klug <stefan.klug@ideasonboard.com>
> > > > > ---
> > > > > =C2=A0drivers/media/platform/nxp/dw100/dw100.c | 27 +++++++++++++=
++++++++------
> > > > >=20
> >=20
> > [...]
> >=20
> > > > > =C2=A0 dev_dbg(&ctx->dw_dev->pdev->dev,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%ux%u %s =
mapping created (d:%pad-c:%p) for stream %ux%u->%ux%u\n",
> > > > > @@ -351,6 +355,7 @@ static int dw100_s_ctrl(struct v4l2_ctrl *ctr=
l)
> > > > > =C2=A0 switch (ctrl->id) {
> > > > > =C2=A0 case V4L2_CID_DW100_DEWARPING_16x16_VERTEX_MAP:
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->user_=
map_is_set =3D true;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->user_map_n=
eeds_update =3D true;
> > > >=20
> > > > This will be called before the new mapping is applied by
> > > > v4l2_ctrl_request_complete(), and then may be cleared too soon if y=
ou queue
> > > > depth is high enough.
> > >=20
> > > v4l2_ctrl_request_complete() does not apply a mapping, what am I miss=
ing
> > > ?
> >=20
> > Sorry for my confusion, after reading back, you are correct, this is ca=
lled
> > v4l2_ctrl_request_setup() inside the device_run() function. You can dis=
miss the
> > bit about user_map_needs_update in my review (the paragraph below).
> >=20
>=20
> That means nothing has to change here, right?

Correct.

>=20
> > >=20
> > > > Instead, you should check in the request for the presence of
> > > > V4L2_CID_DW100_DEWARPING_16x16_VERTEX_MAP to optimize the updates. =
Yo may still
> > > > set this to true if if there is no request, in the case you also wa=
nted to
> > > > change the original behaviour of only updating that vertex on strea=
mon, but I
> > > > don't see much point though.
> > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > =C2=A0 }
> > > > > =C2=A0
> > > > > @@ -405,6 +410,7 @@ static void dw100_ctrl_dewarping_map_init(con=
st struct v4l2_ctrl *ctrl,
> > > > > =C2=A0 }
> > > > > =C2=A0
> > > > > =C2=A0 ctx->user_map_is_set =3D false;
> > > > > + ctx->user_map_needs_update =3D true;
> > > > > =C2=A0}
> > > > > =C2=A0
> > > > > =C2=A0static const struct v4l2_ctrl_type_ops dw100_ctrl_type_ops =
=3D {
> > > > > @@ -1482,6 +1488,15 @@ static void dw100_device_run(void *priv)
> > > > > =C2=A0 v4l2_ctrl_request_setup(src_buf->vb2_buf.req_obj.req,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 &ctx->hdl);
> > > > > =C2=A0
> > > > > + if (src_buf->vb2_buf.req_obj.req) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dw100_update_ma=
pping(ctx);
> > > > > + } else if (ctx->user_map_needs_update && !ctx->warned_dynamic_u=
pdate) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->warned_dyn=
amic_update =3D true;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_warn(&ctx->=
dw_dev->pdev->dev,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "V4L2 requests are required to update the=
 vertex map dynamically"
> > > >=20
> > > > Do you know about dev_warn_once() ? That being said, the driver is =
usable
> > > > without requests and a static vertex (and must stay this way to not=
 break the
> > > > ABI). I don't think you should warn here at all.
>=20
> My idea was that I'd like to see the warning once per context and not
> once per boot. Afaik I can't use dev_warn_once() for that.

I didn't catch this detail (commit comment welcome), fair enough if that's =
the
direction we are heading. Again, I don't understand why we don't just apply=
 that
on next device_run in "legacy" mode.

>=20
> > >=20
> > > Applications should move to using requests. We'll do so in libcamera
> > > unconditionally. I don't expect many other direct users, so warning t=
hat
> > > the mapping won't be applied when an application sets the correspondi=
ng
> > > control during streaming without using requests seems fair to me. It
> > > will help debugging issues.
> >=20
> > It is also a miss-use of dev_warn which is meant to indicate a problem =
with the
> > driver or the hardware. The V4L2 core uses dev_dbg() or customer log le=
vel for
> > that in general. Also, don't re-implement _once() variants with
> > warned_dynamic_update please. Personally, I would just let the out-of r=
equest
> > change the control on the next device_run(), even if that means its out=
 of sync.
>=20
> But then you end up with potentially difficult to debug issues, because
> users would not know that they should use requests. Not warning (or
> dev_dbg) has the same effect from my point of view, because users just
> see a device not working as expected. Is a customer log level the
> solution?

Custom level are hard to discover for sure, but the rules around dev_warn()
aren't mine. We can perhaps makes an argument that the driver is broken, bu=
t why
don't we fix it to match the V4L2 spec is still unknown, specially that its=
 an
easy fix match the V4L2 spec (even if in practice, this is not quite usable=
).
Normally everything else we add above the V4L2 spec, specially stuff using
request get a domain specific spec. With that in hand, we could create bett=
er
rules, but otherwise I don't have much foundation to make a good call here.

Nicolas

>=20
> Best regards,
> Stefan
>=20
> >=20
> > Nicolas
> >=20
> > >=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 );
> > > > > + }
> > > > > +
> > > > > =C2=A0 v4l2_ctrl_request_complete(src_buf->vb2_buf.req_obj.req,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0 &ctx->hdl);
> > > > >=20

--=-WOl4j+GsYoelptSN5dqf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaV0p5AAKCRDZQZRRKWBy
9FTJAP9laFUh4oNuGbatX55S4EZoM1i0MWKK4qSoXWvoIj5h2QEAnSLwsjCq+Wgq
EGsT96v3o5wXkrMLCHylAnMUoqhgLw8=
=lDcR
-----END PGP SIGNATURE-----

--=-WOl4j+GsYoelptSN5dqf--
