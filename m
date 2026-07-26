Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46573E3C50
	for <linux-rt-devel@lists.linux.dev>; Sun, 26 Jul 2026 22:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785106371; cv=none; b=C/x63g9JQ1s8Xb8jo+FgUBJqYeDL9eFHJ+lQ3cvvbKj3zSQq+ZPDDnXXbhKVM1h7c6+kRBwD2CapMvLPbOuXyqdbq83jXCoEIzXF3nOmD5SQ2yqglHNJLIzR2F1HhrtCdnBIzrXh6XYMBgJG5zvaKpnVTtqCq9fGsu2Y43uVlJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785106371; c=relaxed/simple;
	bh=xDNPf5aaMSNLtb7SAWbNzXxYrX6vLdpI4kS6db+emeQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c31KU+y9Bv9Vp49gwx80yNxDTvIYB2I+OSKNxd6LdLeeuc+tg1D6axxVmW2CbBcqRO5qShKIcu552fKR1gVqcBQkhc0yMg3/3i7XfChLUnzMUhYHgGBERN+LaXUOoeToJt7rdnqUyTnD7YeCT3JvL2XB0lR4Nsw1oRdJxEIPm0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=kkt81fIl; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="kkt81fIl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785106356; x=1785711156; i=spasswolf@web.de;
	bh=8l3eJD6nhe7kjpa9/EaalXr1CNpIwr61fsdjzJo5IfA=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kkt81fIlyT2Y6HUxU2sayUQCcTLH7e9gwugKstI6N/c06Ex7O+eIKSHcFoM7WN1I
	 6WRXF3663clhyKyvg9VBzkbb3DBDPIk+4RH9pZ/eLzDxrXJt0PTuF4IHe+qFYrq56
	 y6bkF1O2vkwaV+VbcpDGo0xDMhorSocmScIuZDO/+UqRDykANz9qwb3/hAbQwwyAE
	 QtDifs5WXcR4Unr8WwX2+zXpsY2vSYTYEVOy5Iv7Qr/gGXqgT7HxMVypUZoYMZ1+V
	 /+WztqlBONR+ENVt5Yunf/eqyierTPiDRyVqsgYzWqeob2Vajzsyp2Th1pULg/H2V
	 6lfanCmsogPCFneIUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5UkQ-1x2waf3TJ4-00sAdS; Mon, 27
 Jul 2026 00:52:35 +0200
Message-ID: <f012ef660c71e5d85bd746caab2f6a6e456671de.camel@web.de>
Subject: Re: [Re] kernel panic during shutdown in  next-20260722
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org, Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner	 <tglx@linutronix.de>,
 spasswolf@web.de
Date: Mon, 27 Jul 2026 00:52:34 +0200
In-Reply-To: <6e0b713cffd64b3c30eb4ff04e50721bac9cf8ca.camel@web.de>
References: <20260723131001.11565-1-spasswolf@web.de>
												 <d24a136539c5931984f4855ad6596ca7aee8ebe2.camel@web.de>
										 <1a0800888c2fcd42f1fcd661d8f6f50580ac2fd4.camel@web.de>
									 <4d7c2dd588cd77d1d112da473f2a262d22051d57.camel@web.de>
								 <3c1be47abfcc907e7c1f9696cb25a24c93415a28.camel@web.de>
							 <dc5f1cfb267b0fb522b8aaa236b71b23e236df4d.camel@web.de>
						 <4af8467060c5ee136c2b99ab855a007fec4e8c6c.camel@web.de>
			 <6e0b713cffd64b3c30eb4ff04e50721bac9cf8ca.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fQqRly0LUPpdwL8qtkC/cnwRdENIppHpNDrnPiks9ISos/IxKLA
 VCDI2g4zKBKAj9sPX4jX6H7gibixsmoa8P257XKAoYT6SPP0IlC5/oxjE+Ghqcn8ZcW8rbQ
 iQlkGwVUFpJLvNlFF/5E1yRGnaVJIzqqCN9b41su4NhNaowmR2bgkWQfqQZeJ9N967hqVCD
 B4TTZgpShE+eJC9kmfHAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z/VNGdAwPwo=;R7hdldhPcXjPtHoZ1ncOsSRajlc
 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
 /+VwxnxpuzuTO3dN3B8rdXAMmm5IZMv85ad735c

Am Sonntag, dem 26.07.2026 um 20:47 +0200 schrieb Bert Karwatzki:
> Am Sonntag, dem 26.07.2026 um 01:16 +0200 schrieb Bert Karwatzki:
>=20
>=20
> Now I've run a test with
> commit 8bf0cb97edb ("drm/amd/display: Move dml2_destroy to non-FPU compi=
lation unit")
> with the following debugging patch:
>=20

As I had no better idea I started throwing printk()s into the general=20
direction of the bug, and found this after some attempts:


/*************************************************************************=
******
 * Public functions
 *************************************************************************=
*****/
struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
{
 printk(KERN_INFO "%s %d: preempt_count =3D %d\n", __func__, __LINE__, pre=
empt_count());
 struct dc_plane_state *plane_state =3D kvzalloc_obj(*plane_state,
 GFP_ATOMIC);
 printk(KERN_INFO "%s %d\n", __func__, __LINE__);

 if (NULL =3D=3D plane_state)
 return NULL;

 kref_init(&plane_state->refcount);
 dc_plane_construct(dc->ctx, plane_state);

 return plane_state;
}

In the error case this prints "preempt_count =3D 2"! (only if dc_create_pl=
ane_state()
is called from dc_state_create_phantom_plane()).

If I combine this with the "solution" from above

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resourc=
e.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index cb93bfbe9e9e..7a90098ec118 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1693,11 +1693,9 @@ enum dc_status dcn401_validate_bandwidth(struct dc =
*dc,
        }
=20
        if (dc->debug.using_dml2) {
-               DC_FP_START();
                status =3D dml2_validate(dc, context,
                                context->power_source =3D=3D DC_POWER_SOUR=
CE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml2,
                                validate_mode) ? DC_OK : DC_FAIL_BANDWIDTH=
_VALIDATE;
-               DC_FP_END();
        }
=20
        if (validate_mode =3D=3D DC_VALIDATE_MODE_AND_PROGRAMMING && statu=
s =3D=3D DC_OK && dc_state_is_subvp_in_use(context)) {
@@ -1718,11 +1716,9 @@ enum dc_status dcn401_validate_bandwidth(struct dc =
*dc,
        if (validate_mode =3D=3D DC_VALIDATE_MODE_AND_PROGRAMMING && statu=
s =3D=3D DC_FAIL_HW_CURSOR_SUPPORT) {
                /* attempt to validate again with subvp disabled due to cu=
rsor */
                if (dc->debug.using_dml2) {
-                       DC_FP_START();
                        status =3D dml2_validate(dc, context,
                                        context->power_source =3D=3D DC_PO=
WER_SOURCE_DC ? context->bw_ctx.dml2_dc_power_source : context->bw_ctx.dml=
2,
                                        validate_mode) ? DC_OK : DC_FAIL_B=
ANDWIDTH_VALIDATE;
-                       DC_FP_END();
                }
        }
=20
I get in all cases "preempt_count =3D 0" again.

I also monitored the preempt_count with this patch applied
on top of commit
02c3060ee303 ("drm/amdgpu: add support to query vram info from firmware")
(this is the last commit before the problematic patchset
32c1c35b6d8b drm/amd/display: Move FPU Guards From DML To DC - Part 3
4bb2f0721ed8 drm/amd/display: Move FPU Guards From DML To DC - Part 2
3539437f354b drm/amd/display: Move FPU Guards From DML To DC - Part 1)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_surface.c
index 5f12dcca7f71..29f45b556371 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -85,6 +85,7 @@ uint8_t  dc_plane_get_pipe_mask(struct dc_state *dc_stat=
e, const struct dc_plane
  ************************************************************************=
******/
 struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
 {
+       printk(KERN_INFO "%s 0: preempt_count =3D %d\n", __func__, preempt=
_count());
        struct dc_plane_state *plane_state =3D kvzalloc_obj(*plane_state,
                                                          GFP_ATOMIC);
=20

Again I get only 0 for the preempt_count.

Bert Karwatzki
