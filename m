Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5D33B4E9B
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Jul 2026 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394396; cv=none; b=nKv1CeoIx5H5UHArz05BYwcZ041ZmJ/A5RPH/J/oGk9+O7fDOgjDsAnSgbrqc+XNdTrhzFIpTrKRQpUaBdhCPsfUkf+S9AUIW5dDSSFsjQbh3pR5wZMP7WzCbaz6QihCfGBasQo4XA9oj1XrkfSf5m4cbaNYTbh6V3hexYiM/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394396; c=relaxed/simple;
	bh=kyq4Mqzqrl2ra4IUF4UXGWP5uLof/LqbTeeX8rQT3c8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rrpaS5tHkQj1wKA7Ku4ph0LaqjWAxoOkrWtla3F6+HzQkVB4IbP90tFvoUD0hD731RktHxgsBU+J5ratk8JPqNiIRmVzyEda0sK9UVwcZhUKwY3aQxBewKIsvYEouuSSlaoyzJanfnmZk6YBeCKai8AhFVO1Mn20KSoApdFIp64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPottEDk; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPottEDk"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso1877668e87.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 29 Jul 2026 23:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785394389; x=1785999189; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XRuFZ6h1uhegR6Sr4/10z/GSPpr/uGFR1omQDwMWmUQ=;
        b=UPottEDkf0dcpIt+ntOcJxHpmoBvS/FVcRmpSiQBzlJ46/QnGFZLsR2vcgZCmSho+s
         ZJTCUVdsxlTW2YW3U4A3LcdeCI0aMcLvwQyvZaaF+/apcmwK52Nv+vHDbNrsCjq10NUj
         uvCi3OXbpnMP0OfwEdY7uGLmzYQzqUXtmsWcwjGEr3d04fRDFcRQFBL3s2FjncZScE1O
         INjtbI1UUfULel+t9Um0YbsefnGcmaumzq/rG9sQTrnIJzL7qYS/1nqurqTP80VB4q1W
         kXixMK9x1cUqHFSZ4W7FrNiMd7oLfDUchXMCSHSlkm3RgY1qCUHjYGhAUTx/OK4sio/R
         2UlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394389; x=1785999189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XRuFZ6h1uhegR6Sr4/10z/GSPpr/uGFR1omQDwMWmUQ=;
        b=FjOTRCkxZU8SbcPavoCJa/T2kLUhGXD78cjkdUmoqZaCpSqkj+0XGl4ZnWOohs+NR1
         NW/eP1rqJkxrGSEtZY+5PijyNyEePBGb5Qhy4iL1h9y4OWYwwwDJXv58QFwm5G7l5c9T
         7b2EFzEgA57SKKzJzBZk1I1GFb1MTl6vq6MuokLq6uEFcuRMDDG5miZmmEDZI6xOEU1W
         OWFmqSuNghFx0IpnCcDVcxowhVT7muzrHSFfm9LehwFCZqaKRiXbFguIFtd4ecybQjrM
         XZutu7ZetuqcQAa1BKzXcBF8k5vkZnWjpcpO4Mzj3W4AXZQv6r3TsXB6EXX597sUW1x6
         VBmQ==
X-Forwarded-Encrypted: i=1; AHgh+RpsuU6rh+xYLtSxfexxBBirKw7mPqQgL92IgMYTB4YFbioVr/QXHHtVUwN0rIg6E2djayAnNs8tD6Ye9p2dLQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx85zOb9jSrb80f9BBnexx2cwG/5qVJHmmcJw9LGGvf+xXe9UHP
	IyHSUrtJv5dEwGGoUWiu6eoGEfN0DXJ9//l4Lfaxx35GpprH3meFoDwS
X-Gm-Gg: AR+sD12vSAtCFMUndeNoyEAHANllHmyDKz3OlA++gCc4gmtA2UfC79nwDpSDaRbPLvB
	kWWPU9uXFGrA6gRkTa+5S8/bnKYYalwALQ/i+diTtFtNTaj8SkNbH2aUDVarSDP5q/QjRGO2vHG
	x6k3xaR90FAptQr/Ig3P7HR/3FeUpWnnP7LsL39PBYYZlHwdF9WTx0RcEDvfU3PpzitfGtAZJtY
	SnpWyIHTd0jgETMhwbQ3fnKelNlxVmqp73YzMegeb25UzsdZWVxr2IhphaWpg7Z3K61yB5U0NeO
	36WB3ygwybUsLTKq/q6dylsuWGCgLM1j2nEJcwWIm1GPwB7xDe7rTDttGApcgCoKbGA87PTKnO/
	XvguCWO1WxoGiEnKsKpBb+mqkE55DlzPMQUJf4HtTV98CXTLposScVUcL3zFoOnSMMpw4ykDJhq
	GITK/1X3BWIXF1x0ifpTuLKxTk6sFtUbwf2bjCHZ5+VndoBUFYxoje3Bi6sMmitgeWPRlN+YXgm
	iGIrlCaQbI=
X-Received: by 2002:a05:6512:2245:b0:5ae:c239:6a2c with SMTP id 2adb3069b0e04-5b2db380b43mr251021e87.53.1785394388845;
        Wed, 29 Jul 2026 23:53:08 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f6ac5ea80sm1635701fa.26.2026.07.29.23.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:53:07 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Rafal Ostrowski <rafal.ostrowski@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] drm/amd/display: make DC_RUN_WITH_PREEMPTION_ENABLED misuse a build error
Date: Thu, 30 Jul 2026 11:53:00 +0500
Message-ID: <20260730065300.2056809-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inside an FPU compilation unit DC_FP_START() and DC_FP_END() are defined
as BUILD_BUG(), so using them there fails the build.  That was done on
purpose by
commit a574f53ed52e ("drm/amd/display: Permit DC_FP_START/END only in non-FP compilation units").

DC_RUN_WITH_PREEMPTION_ENABLED() was added later by
commit 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Part 1")
and defined as a plain pass-through in that same branch instead.  A wrap
placed inside an FPU compilation unit therefore compiles cleanly, reads
as correct during review, and does nothing at all.

This is not hypothetical.  While chasing a "scheduling while atomic"
splat in dc_create_plane_state() on PREEMPT_RT, an attempt to place the
guard further up the call chain, in dml21_add_phantom_plane() in
dc/dml2_0/dml21/dml21_utils.c, had no effect for exactly this reason:
dc/dml2_0/Makefile applies CC_FLAGS_FPU to every object under that
directory, and the top level Makefile adds -D_LINUX_FPU_COMPILATION_UNIT
to CC_FLAGS_FPU.

Define the macro as BUILD_BUG() there as well, so that the mistake is a
compile error rather than a guard that silently does nothing.  The code
argument is kept in the expansion so the BUILD_BUG() failure is not
accompanied by set-but-unused diagnostics for variables assigned inside
it.

No current user is affected.  dc/core/dc_stream.c and
dc/resource/dcn32/dcn32_resource.c are outside the dml directories, and
dc/dml2_0/dml2_wrapper.c and dc/dml2_0/dml21/dml21_wrapper.c are built
without the FPU flags because dc/dml2_0/Makefile replaces their CFLAGS
with CC_FLAGS_NO_FPU and removes CC_FLAGS_FPU.

Link: https://lore.kernel.org/all/1ead313022bc62dce1f42af9f855727eb9074443.camel@web.de/
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

This is a build-time change, so there is nothing to reproduce at
runtime.  Verified in both directions on x86_64 with
CONFIG_DRM_AMD_DC_FP=y, by adding
 
	DC_RUN_WITH_PREEMPTION_ENABLED((void)0);
 
to dcn10_resource_construct_fp() in dc/dml/dcn10/dcn10_fpu.c, which is
compiled with CC_FLAGS_FPU and already includes dc_fpu.h.
 
Without the patch 'make drivers/gpu/drm/amd/amdgpu/' compiles that file
and the whole module links, so the guard is silently ineffective.  With
the patch the build stops there:
 
  dcn10_fpu.c: In function 'dcn10_resource_construct_fp':
  include/linux/compiler_types.h:702:45: error: call to
    '__compiletime_assert_524' declared with attribute error: BUILD_BUG failed
  dc_fpu.h:56:17: note: in expansion of macro 'BUILD_BUG'
  dcn10_fpu.c:129:9: note: in expansion of macro 'DC_RUN_WITH_PREEMPTION_ENABLED'
 
No set-but-unused diagnostics accompany it.  Removing the added line
builds cleanly again.

 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
index 5e95419d3798..e89b39a4aa83 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
@@ -51,7 +51,11 @@ void dc_fpu_end(const char *function_name, const int line);
 #else
 #define DC_FP_START()	BUILD_BUG()
 #define DC_FP_END()	BUILD_BUG()
-#define DC_RUN_WITH_PREEMPTION_ENABLED(code) code
+#define DC_RUN_WITH_PREEMPTION_ENABLED(code) \
+	do { \
+		BUILD_BUG(); \
+		code; \
+	} while (0)
 #endif // !_LINUX_FPU_COMPILATION_UNIT
 
 #endif /* __DC_FPU_H__ */
-- 
2.55.0

