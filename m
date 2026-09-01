Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EF038F651
	for <linux-rt-devel@lists.linux.dev>; Tue,  1 Sep 2026 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271309; cv=none; b=uWm4lcWXQMDgiRZf8Y69zqpu/ArmJPLlx6dphfj2dnG2K5a1fjffDMMWEK6UuzsaO0n7gEpF1g6i3/wJ1QVbUpWs4GXftHyCxcPCSdyyQuHrFBjnCqCtEjhAlhafGsNRLCCKTHPsuYAnx1Kdyvt358R/uEvg89Tm+aLhtfn3ZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271309; c=relaxed/simple;
	bh=LGqHcJi0jynPzMwGmQCyD6Y0ne2NBLhxWF7T+F8ggso=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QuhVWNOwFIXmoI7udaNxUgR9v3J9/cWj/h6xFOGzEdyBCBLHrWdyG5yq8k8MUhUGRVH7jtltiWgM5HtpPOuXRHvBN5RuJ/VYxOCSEImDBLD5sEkyw4Yi46K158LUjuMCCR/3LfNe6Hs9MNrs6NGRB5mD6dYq+DLoCVY+T/hl6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=usFls2uh; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="usFls2uh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1788271275; x=1788876075; i=spasswolf@web.de;
	bh=ycMb1TDkvlRkxtPIVSmqSP3CEgBZvs2AKRL75Jrxt3Q=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=usFls2uhmVNMShceMUEdlt0hBD3SWFeDWVE5APquRwasHOuEpJueaiRhArSrgt5U
	 9Q25EPnQSJWFOmcHGq/qh6Zg9G2O/YNTYtzYw3XO6D95wudKXAat9Ev5yiDdKG5tJ
	 B/zZCnqR/G4T6frmwM4OstYEgYFfiPR/cmgtXSM3wDA/knPErEvutWqzjlpAxyhww
	 K80Pt0LSm0B+R860DefLG5GGGY2E7qYJ5XWrMKuXae8gwGgPmAwjePNgk8Y/lob30
	 1D3OwoJxI4eWqaGZ5jLjp8fLI9FmfMVR4t/Q+EDNUTLUiRLaZidzbBYg8sLe/6p/y
	 Bgm1or973tDZyWmEDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFs1t-1x6dhl46Ln-00BDkE; Tue, 01
 Sep 2026 16:01:15 +0200
Message-ID: <673ff4d5f23be979766397b4a58c05e61f2f3ec4.camel@web.de>
Subject: Re: [PATCH v7.2-rc6] drm/amd/display: fix usage of
 DC_FPU_{BEGIN,END} with PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, amd-gfx@lists.freedesktop.org, Mikhail
 Gavrilov	 <mikhail.v.gavrilov@gmail.com>, Alex Deucher
 <alexander.deucher@amd.com>,  Rafal Ostrowski <rafal.ostrowski@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Thomas Gleixner	
 <tglx@linutronix.de>, spasswolf@web.de
Date: Tue, 01 Sep 2026 16:01:14 +0200
In-Reply-To: <20260828095511.zrVXJUrU@linutronix.de>
References: <202608061233.eufnR5Qm-lkp@intel.com>
	 <20260807124944.154232-1-spasswolf@web.de>
	 <20260827124931.ocQEF6MW@linutronix.de>
	 <bd31938661f178abaa68d3958bacdc1ebb70ff5c.camel@web.de>
	 <20260828095511.zrVXJUrU@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sfV7yMNie26CRgKczyXCJ0gT4keq9aMZuivunikWo/fzHZ43H5t
 bm6IJl+bVe3Fzs7gF1jiCznKNecXsIKD6y6IpBrSaLKPKMAZc0aI+tdzyqysJ7SIx0fDZ4j
 iuQeF2Cd05nQXQzEeD6TXzsQ8XDxKwZVo/KlemCnJXAW7QD1l+i3t5Sbr58RK9nqOWk2XfA
 dg/xygCs+tK0CzbA0gO7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:omyrJnyA8gc=;d9ektgr5C2I3j/VGdoiZ01FxKqV
 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

>=20
> > >=20
> > > Could the FPU regions with disabled preemption be limited to where w=
e
> > > have actually have FPU usage in way that you don't have to worry whe=
n it
> > > is needed to use DC_RUN_WITH_PREEMPTION_ENABLED() and when not? Also=
 the
> > > dc_fpu_begin()/ end() can nest and if they do the usage of
> > > DC_RUN_WITH_PREEMPTION_ENABLED() is futile, isn't it?
> > >=20
> >=20
> > I'm not very familiar with the amd display engine, and it's a lot of c=
ode,
> > but there I think there's some room for improvement, e.g. dml2_destroy=
():
> >=20
> > dml2_destroy is called from dc_state_free() from within DC_FP_{START,E=
ND}()
> > and then basically just calls vfree with DC_RUN_WITH_PREEMPTION_ENABLE=
D().
> > (directly or through dml21_destroy()). Here both the DC_FP_*() tags an=
d
> > DC_RUN_WITH_PREEMPTION_ENABLED() could be dropped I think (not tested,=
 yet)
> >=20

Now, I've tested dropping some DC_FP_START,END() and DC_RUN_WITH_PREEMPTIO=
N_ENABLED().
(Patch for next-20260828+ with the fix above applied)
This works without error so far.
The function dml2_create() and dml2_create_copy() are moved to a non-FPU f=
ile so they
do not accidently use FPU instruction (they do not use FPU instruction on =
x86_64 when
compiled with gcc-16 but other architectures and compilers could probably =
use them).

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/=
drm/amd/display/dc/core/dc_state.c
index 666212cac105..709c37d2072f 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -209,9 +209,7 @@ struct dc_state *dc_state_create(struct dc *dc, struct=
 dc_state_create_params *p
 	bool status;
=20
 	if (dc->debug.using_dml2) {
-		DC_FP_START();
 		status =3D dml2_create(dc, &dc->dml2_options, &state->bw_ctx.dml2);
-		DC_FP_END();
=20
 		if (!status) {
 			dc_state_release(state);
@@ -221,9 +219,7 @@ struct dc_state *dc_state_create(struct dc *dc, struct=
 dc_state_create_params *p
 		if (dc->caps.dcmode_power_limits_present) {
 			bool dc_power_status;
=20
-			DC_FP_START();
 			dc_power_status =3D dml2_create(dc, &dc->dml2_dc_power_options, &state=
->bw_ctx.dml2_dc_power_source);
-			DC_FP_END();
=20
 			if (!dc_power_status) {
 				dc_state_release(state);
@@ -251,17 +247,13 @@ void dc_state_copy(struct dc_state *dst_state, struc=
t dc_state *src_state)
 #ifdef CONFIG_DRM_AMD_DC_FP
 	dst_state->bw_ctx.dml2 =3D dst_dml2;
 	if (src_state->bw_ctx.dml2) {
-		DC_FP_START();
 		dml2_copy(dst_state->bw_ctx.dml2, src_state->bw_ctx.dml2);
-		DC_FP_END();
 	}
=20
 	dst_state->bw_ctx.dml2_dc_power_source =3D dst_dml2_dc_power_source;
=20
 	if (src_state->bw_ctx.dml2_dc_power_source) {
-		DC_FP_START();
 		dml2_copy(dst_state->bw_ctx.dml2_dc_power_source, src_state->bw_ctx.dml=
2_dc_power_source);
-		DC_FP_END();
 	}
 #endif // CONFIG_DRM_AMD_DC_FP
 	/* context refcount should not be overridden */
@@ -285,9 +277,7 @@ struct dc_state *dc_state_create_copy(struct dc_state =
*src_state)
 	new_state->bw_ctx.dml2_dc_power_source =3D NULL;
=20
 	if (src_state->bw_ctx.dml2) {
-		DC_FP_START();
 		status =3D dml2_create_copy(&new_state->bw_ctx.dml2, src_state->bw_ctx.=
dml2);
-		DC_FP_END();
=20
 		if (!status) {
 			dc_state_release(new_state);
@@ -297,10 +287,8 @@ struct dc_state *dc_state_create_copy(struct dc_state=
 *src_state)
=20
=20
 	if (src_state->bw_ctx.dml2_dc_power_source) {
-		DC_FP_START();
 		status =3D dml2_create_copy(&new_state->bw_ctx.dml2_dc_power_source,
 					  src_state->bw_ctx.dml2_dc_power_source);
-		DC_FP_END();
=20
 		if (!status) {
 			dc_state_release(new_state);
@@ -389,13 +377,11 @@ static void dc_state_free(struct kref *kref)
 	dc_state_destruct(state);
=20
 #ifdef CONFIG_DRM_AMD_DC_FP
-	DC_FP_START();
 	dml2_destroy(state->bw_ctx.dml2);
 	state->bw_ctx.dml2 =3D 0;
=20
 	dml2_destroy(state->bw_ctx.dml2_dc_power_source);
 	state->bw_ctx.dml2_dc_power_source =3D 0;
-	DC_FP_END();
 #endif
=20
 	kvfree(state);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c b=
/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
index 8bed59e976d1..29e5cce51b99 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
@@ -23,11 +23,11 @@
=20
 static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 {
-	DC_RUN_WITH_PREEMPTION_ENABLED(*dml_ctx =3D vzalloc(sizeof(struct dml2_c=
ontext)));
+	*dml_ctx =3D vzalloc(sizeof(struct dml2_context));
 	if (!(*dml_ctx))
 		return false;
=20
-	DC_RUN_WITH_PREEMPTION_ENABLED((*dml_ctx)->v21.dml_init.dml2_instance =
=3D vzalloc(sizeof(struct dml2_instance)));
+	(*dml_ctx)->v21.dml_init.dml2_instance =3D vzalloc(sizeof(struct dml2_in=
stance));
 	if (!((*dml_ctx)->v21.dml_init.dml2_instance))
 		return false;
=20
@@ -37,7 +37,7 @@ static bool dml21_allocate_memory(struct dml2_context **=
dml_ctx)
 	(*dml_ctx)->v21.mode_support.display_config =3D &(*dml_ctx)->v21.display=
_config;
 	(*dml_ctx)->v21.mode_programming.display_config =3D (*dml_ctx)->v21.mode=
_support.display_config;
=20
-	DC_RUN_WITH_PREEMPTION_ENABLED((*dml_ctx)->v21.mode_programming.programm=
ing =3D vzalloc(sizeof(struct dml2_display_cfg_programming)));
+	(*dml_ctx)->v21.mode_programming.programming =3D vzalloc(sizeof(struct d=
ml2_display_cfg_programming));
=20
 	if (!((*dml_ctx)->v21.mode_programming.programming))
 		return false;
@@ -51,15 +51,17 @@ bool dml21_create(const struct dc *in_dc, struct dml2_=
context **dml_ctx, const s
 	if (!dml21_allocate_memory(dml_ctx))
 		return false;
=20
+	DC_FP_START();
 	dml21_init(in_dc, *dml_ctx, config);
+	DC_FP_END();
=20
 	return true;
 }
=20
 void dml21_destroy(struct dml2_context *dml2)
 {
-	DC_RUN_WITH_PREEMPTION_ENABLED(vfree(dml2->v21.dml_init.dml2_instance));
-	DC_RUN_WITH_PREEMPTION_ENABLED(vfree(dml2->v21.mode_programming.programm=
ing));
+	vfree(dml2->v21.dml_init.dml2_instance);
+	vfree(dml2->v21.mode_programming.programming);
 }
=20
 void dml21_copy(struct dml2_context *dst_dml_ctx,
@@ -88,7 +90,9 @@ void dml21_copy(struct dml2_context *dst_dml_ctx,
 	dst_dml_ctx->v21.mode_programming.programming =3D dst_dml2_programming;
=20
 	/* need to initialize copied instance for internal references to be corr=
ect */
+	DC_FP_START();
 	dml2_initialize_instance(&dst_dml_ctx->v21.dml_init);
+	DC_FP_END();
 }
=20
 bool dml21_create_copy(struct dml2_context **dst_dml_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c b/driver=
s/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
index 1772e74349c7..570da14fb1a7 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
@@ -21,7 +21,7 @@ struct dml2_context *dml2_allocate_memory(void)
 {
 	struct dml2_context *dml2;
=20
-	DC_RUN_WITH_PREEMPTION_ENABLED(dml2 =3D vzalloc(sizeof(struct dml2_conte=
xt)));
+	dml2 =3D vzalloc(sizeof(struct dml2_context));
 	return dml2;
 }
 bool dml2_validate(const struct dc *in_dc, struct dc_state *context, stru=
ct dml2_context *dml2,
@@ -51,7 +51,9 @@ bool dml2_validate(const struct dc *in_dc, struct dc_sta=
te *context, struct dml2
 static void dml2_init(const struct dc *in_dc, const struct dml2_configura=
tion_options *config, struct dml2_context **dml2)
 {
 	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version >=3D DCN_VERS=
ION_4_01)) {
+		DC_FP_START();
 		dml21_reinit(in_dc, *dml2, config);
+		DC_FP_END();
 		return;
 	}
=20
@@ -82,11 +84,13 @@ static void dml2_init(const struct dc *in_dc, const st=
ruct dml2_configuration_op
 		break;
 	}
=20
+	DC_FP_START();
 	initialize_dml2_ip_params(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.ip);
=20
 	initialize_dml2_soc_bbox(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc);
=20
 	initialize_dml2_soc_states(*dml2, in_dc, &(*dml2)->v20.dml_core_ctx.soc,=
 &(*dml2)->v20.dml_core_ctx.states);
+	DC_FP_END();
=20
 }
=20
@@ -116,17 +120,52 @@ void dml2_destroy(struct dml2_context *dml2)
 	if (dml2->architecture =3D=3D dml2_architecture_21)
 		dml21_destroy(dml2);
=20
-	DC_RUN_WITH_PREEMPTION_ENABLED(vfree(dml2));
+	vfree(dml2);
 }
=20
 void dml2_reinit(const struct dc *in_dc,
 				 const struct dml2_configuration_options *config,
 				 struct dml2_context **dml2)
 {
+	/*
 	if ((in_dc->debug.using_dml21) && (in_dc->ctx->dce_version >=3D DCN_VERS=
ION_4_01)) {
+		DC_FP_START();
 		dml21_reinit(in_dc, *dml2, config);
+		DC_FP_END();
 		return;
 	}
+	*/
=20
 	dml2_init(in_dc, config, dml2);
 }
+
+/* Moved here from dml2_wrapper_fpu.c */
+void dml2_copy(struct dml2_context *dst_dml2,
+	struct dml2_context *src_dml2)
+{
+	if (src_dml2->architecture =3D=3D dml2_architecture_21) {
+		dml21_copy(dst_dml2, src_dml2);
+		return;
+	}
+	/* copy Mode Lib Ctx */
+	memcpy(dst_dml2, src_dml2, sizeof(struct dml2_context));
+}
+
+/* Moved here from dml2_wrapper_fpu.c */
+bool dml2_create_copy(struct dml2_context **dst_dml2,
+	struct dml2_context *src_dml2)
+{
+	if (src_dml2->architecture =3D=3D dml2_architecture_21)
+		return dml21_create_copy(dst_dml2, src_dml2);
+	/* Allocate Mode Lib Ctx */
+	*dst_dml2 =3D dml2_allocate_memory();
+
+	if (!(*dst_dml2))
+		return false;
+
+	/* copy Mode Lib Ctx */
+	dml2_copy(*dst_dml2, src_dml2);
+
+	return true;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c b/dr=
ivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
index a14e3004a7b7..b590d58ad3a9 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
@@ -561,31 +561,3 @@ void dml2_prepare_mcache_programming(struct dc *in_dc=
, struct dc_state *context,
 		dml21_prepare_mcache_programming(in_dc, context, dml2);
 }
=20
-void dml2_copy(struct dml2_context *dst_dml2,
-	struct dml2_context *src_dml2)
-{
-	if (src_dml2->architecture =3D=3D dml2_architecture_21) {
-		dml21_copy(dst_dml2, src_dml2);
-		return;
-	}
-	/* copy Mode Lib Ctx */
-	memcpy(dst_dml2, src_dml2, sizeof(struct dml2_context));
-}
-
-bool dml2_create_copy(struct dml2_context **dst_dml2,
-	struct dml2_context *src_dml2)
-{
-	if (src_dml2->architecture =3D=3D dml2_architecture_21)
-		return dml21_create_copy(dst_dml2, src_dml2);
-	/* Allocate Mode Lib Ctx */
-	*dst_dml2 =3D dml2_allocate_memory();
-
-	if (!(*dst_dml2))
-		return false;
-
-	/* copy Mode Lib Ctx */
-	dml2_copy(*dst_dml2, src_dml2);
-
-	return true;
-}
-


Bert Karwatzki
