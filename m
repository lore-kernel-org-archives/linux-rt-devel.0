Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721A92F6188
	for <linux-rt-devel@lists.linux.dev>; Tue,  6 Jan 2026 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714124; cv=none; b=thbYVeYuKFRL+if5tgIO+iVQYdFZJV4rfC2uZuOYCE3ZdzD53pC6qpnm6iheS7hVD/AxjN/w2sMlVlq6DP/bAF9BF6ECHSJ2JOygw6eqa5x0XpJjTqe4oj3R6dFd0w/iNHaFcTFu1J7/N87xVnrcP20zsjncPOoYRKjyeEQoeBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714124; c=relaxed/simple;
	bh=ZyHIVjtaj7HpnU+gARNjSz9uHM0V5SJQC9EL6UP72qc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RWy37uXmICYvmrQRExNuJVTnWl8aFp1OvaY1aa+003d2lpm6eR7BKAYF5sUvfN2eRhdJ25IIi1h7NXx9FNGz/xplWucUYQ4Pet/2Dh+PtPgfjU3Oyxu12THJsPYGe0tNt2uGbItMh1C6U1rq8vaavmubei+btF778G65S2nvfEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=0fTOzOaE; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="0fTOzOaE"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c0d16bb24dso89319785a.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 06 Jan 2026 07:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1767714119; x=1768318919; darn=lists.linux.dev;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyHIVjtaj7HpnU+gARNjSz9uHM0V5SJQC9EL6UP72qc=;
        b=0fTOzOaENitGK83nFcpjoJadnxtKSoOmMQk/KDOfyzhvhtuyuguqZkLYNwyiU/2Pp8
         sfp9bd+0QRBjSoAvK9hkZPqnpPX7YhDOxcmBPC3vUhbrUJ+ofToC+dTJlROifqZrYXBz
         SAaxdz+0kLj7y+Z1WXO6L0KgM+M/+qYQOn0z+1AFi0DZpDmAwIF7sQuu1LWCdLitEVej
         /iEqvrPuczmlYNLlhMW3rDiauWwmXUaCPW/ZAdbSrDFaaONbjbhT6eo/utsXEv9jvG2w
         CH+slMtU7unxTi+QzK5ZKt12u0/0IFuX2YCltiuFso7nm4TAzYV3vU5ArxVEapaMz6q6
         RYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767714119; x=1768318919;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZyHIVjtaj7HpnU+gARNjSz9uHM0V5SJQC9EL6UP72qc=;
        b=DTBLFo3TetAMh1X0EDZ5kOpXZhrl9gBL/GREEV7cU0DqRpQj/K4tm3oTULrPbvxFho
         v51MhSAOsLotKkRcIMTpfNPkFWygUrJuiZhn/KaJtlWtImc74omIIy2x1oz19vEHGS5a
         16HMeJDqQ9fFcs2mpp9J/4WLQ8b2M/zcEibp06ODn8C+mDpJlmSo6UJ5E2zaU4k3Ceb7
         yOE+5/pNPhXItVR/kYFnu9eSgC3yvOc639pEKrZNDVXvcVNDcc64te3dz+sHlhXJ5K6h
         FvM5072hiAcHUJddr8oFKgp7Q/zhjodjJtseDCe107x0e807LWq37Vss/yokoXxM2F5l
         5kJA==
X-Forwarded-Encrypted: i=1; AJvYcCUHYrDO0/GMdt//kakRblkaUz6IEvysql0ROrIGW7f9CJYbIqYXZB8dEcTm5JRLnYYbXuNdA9xJctP03BcvXA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7BC7/AdmsYuxIJEQ6SRzDtW8b9IlBySixCnROxnEBg4O9dOGJ
	apO31fr4mVh1fOsBsbMO2ZikOMf7iH8IeaVkzu8Cn5NS+3AOq+rSRovqnaSDWv2teEM=
X-Gm-Gg: AY/fxX793pRr+JAjfSIP4AUB9JZNw5CS0MK00/Zks2wf4HBvG10t99Qlfu4OsYR/fOo
	6q2JMLvqqKHUqSebAnU/dwry1rPBns5cUbpm8QeuRIXIWjtHedAloLrOjHFykgIeiNggH/eSh7l
	hePBMr+tKf3XZENulJgeLQgEuw73Ie3lpRaRHdWgidwLWM++8ECvNfDGsXkDFfmNxoj623aGeQh
	J1OzzVhuTMDr5v3aFuFcp9ldrgmpVv7kfh/3Qx3w+a+kMERFp3feCcSQCeb+KfzgHe7mtc9KgXG
	VC8IJyjfbaT0GVbaux8/Gmc9cZtW/6j8XPTcNRMyhiLxXJQemKJSl5bxNIBgIqgRZNiHj6Ky3Ai
	LGfMCoFfBDa9rJBgu05tJvq4A26+2tp9XfSlQWLjKlJlMQbBZlicRf8TQJVwmC1Ginf9RF3JJFs
	tLfhCSWMSOsAjXkOGt
X-Google-Smtp-Source: AGHT+IGOjr7+Fr5tWYcAPd24+dhrl2pCBfmz4dMnYF307/sgHCL4jktrKPsJUTO8WaP3DJTmPx3M7w==
X-Received: by 2002:a05:620a:4623:b0:892:a186:6b4f with SMTP id af79cd13be357-8c37ebb50fdmr482415285a.77.1767714118936;
        Tue, 06 Jan 2026 07:41:58 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:7b4b::5ac? ([2606:6d00:17:7b4b::5ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f540650sm187549385a.47.2026.01.06.07.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:41:58 -0800 (PST)
Message-ID: <f4eef909a0f9b787dd4720fe005de0c4e41f5c5a.camel@ndufresne.ca>
Subject: Re: [PATCH 1/4] media: dw100: Implement V4L2 requests support
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Klug
	 <stefan.klug@ideasonboard.com>
Cc: Xavier Roumegue <xavier.roumegue@oss.nxp.com>, Mauro Carvalho Chehab	
 <mchehab@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Hans Verkuil	
 <hans@jjverkuil.nl>
Date: Tue, 06 Jan 2026 10:41:56 -0500
In-Reply-To: <20260106145354.GB26157@pendragon.ideasonboard.com>
References: 
	<20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-0-65af34d04fd8@ideasonboard.com>
	 <20260105-sklug-v6-16-topic-dw100-v3-1-dev-v1-1-65af34d04fd8@ideasonboard.com>
	 <40dfd12b585681d8edf9641967160c086cc120c3.camel@ndufresne.ca>
	 <20260106003302.GJ10026@pendragon.ideasonboard.com>
	 <176770897731.12184.12302111059048415045@localhost>
	 <20260106145354.GB26157@pendragon.ideasonboard.com>
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
	protocol="application/pgp-signature"; boundary="=-w6Qd9dvsJZkBofCWsLKx"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0


--=-w6Qd9dvsJZkBofCWsLKx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

Le mardi 06 janvier 2026 =C3=A0 16:53 +0200, Laurent Pinchart a =C3=A9crit=
=C2=A0:
> CC'ing Hans Verkuil for two questions below.
> >=20

[...]

> > The docs say "a buffer that was never queued to the driver but is
> > associated with a queued request was canceled..." So to my understandin=
g
> > the only purpose of this function is to mark all controls in the reques=
t
> > as being handled, so that the request can be finished.
>=20
> That doesn't explain why it should be done twice per request. Hans,
> could you clarify this ?

I explained it in another thread, it is only called if device_run() is not =
going
to be called, so only once. vb2 does not have access to the the control han=
dler,
so it can't call the v4l2_ctrl_request_complete() fonction directly.

>=20
[...]

> > Nicolas, if I go you right you mean that one might be tempted to do
> >=20
> > v4l2_ctrl_request_setup()
> > v4l2_m2m_buf_done(src)
> > v4l2_m2m_buf_done(dst)
> > v4l2_ctrl_request_complete()
> >=20
> > which feels natural from the names of the functions, but the
> > v4l2_m2m_buf_done(src) might complete the request if it has no
> > associated controls and therefore the later v4l2_ctrl_request_complete(=
)
> > would fail...
> >=20
> > I see that the usage of v4l2_m2m_buf_done_and_job_finish() is more
> > compact and will use that in v2. For the sake of understanding: The onl=
y
> > functional issue with my code is that v4l2_m2m_buf_done(src_buf) is
> > called before v4l2_m2m_buf_done(dest_buf), right?
>=20
> Is that an issue, why would the destination buffer need to be completed
> first ?

The VB2 media_request_object is being removed from the request once the OUT=
PUT
(src) buffer is marked done. If this was the last media_request_object, the
request will move to completed state, which will signal its FD.

If you do that before you mark the CAPTURE (dst) buffer as done, an applica=
tion
that uses non blocking IOs may endup calling DQBUF(dst) too soon, which wil=
l
return EBUSY. Since we really want the request FD to be used as the only
synchronisation point, we made the rule that the request FD must be signall=
ed
last. Since its error prone, and its not illegal to synchronise on the devi=
ce
read/write/pri state, we made a condensed helper for it.

Alternatively, the manual request completion is being added for cases this
implicit request completion does not work, or when it makes everything too
complicated to adhere to this rule. This is the case for dual-stage video
decoders (MTK/RPi).

Nicolas


[...]

--=-w6Qd9dvsJZkBofCWsLKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaV0tRAAKCRDZQZRRKWBy
9I2cAP40X1kizGKniAJpnsxW2HVfKMWON8DejJHlAutRKMtHtQEA9121yKIa29+0
ZM9e4HsunUX7z6c6rzdYPCcV1KvYeAg=
=PX6j
-----END PGP SIGNATURE-----

--=-w6Qd9dvsJZkBofCWsLKx--
