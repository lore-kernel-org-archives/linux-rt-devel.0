Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654201;
	b=P2ODLE+oMahpasg9AoO4/T8Qa+L0Sxtnv4f6SG+qOACZwwOBE59fiUNaSPgaULn3/VGA
	 WJHcPw7/v3MqJJNms0c11RkQZDbAEzrWh4JrpaVHBkcGZzexP8ABKIb8c1GRt9ODE5Lmi
	 6fsTODeisQawL6m7/oL3W4thqb4GF7dob8nSLWWAUMXC6pvHFrgeFXayly/A136fa2uYR
	 6TIkjjBhjJNPyLyJHp/yfp2kPJiBuz50uKeSD4YbuQPNdWEmS5S98PSmyyWBv1Ho94fFc
	 4RZrccL6SI2AdkmS/Z+C1VbCuGAPxRvU8/plUhMQ8z5udt4KY3ckEQql6wt9yBmgAhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654201;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=u/8iyy4HZ7/aVXuOHPUsPysy0WI5/Kcxb2nLLftofoI=;
	b=BAAgb1LepZJ/YjKaMTUzk3/U+Kk/WqPWYRjotAiXRhAr+X9UjkkdnGJe1NhrFa0VKnGt
	 M9CA0+plDOoxiwSGfwryR4slrxGp9O3remtczGQljISGK5lNwdrkWWw70QxvDizLy/BN1
	 RH2X9ToekwZDg87KqKm8qkPkPZb9SOqlFUJyws6GKRpWPV3MaYQYJLvDcQoHZLsDm5PfN
	 6QAj9PZTI/P3P8gWl40hsYvY2GwkPurnUxdk1546IcH/cC5wVjEB9uDrLKP/Zw8dzdPht
	 SuMwSBmzqFmju+UPfSh9tFXk6cJh/shr9F3VMYgA/lFkvdGTMQXga4CJkLk134yy35w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KfIZcCjS;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D6606A32D
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Nov 2026 21:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B1D6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KfIZcCjS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793654200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/8iyy4HZ7/aVXuOHPUsPysy0WI5/Kcxb2nLLftofoI=;
	b=KfIZcCjSQp+/TDRQij30V06YWyk70Lc4D8Ks7QqG6b/nilBZIA4kk6nIA9wI6bca5JSyTg
	xhhAo/OlWFgioK4sfqV6oMEHvwCo1B1k3KL9vKCTQ1fUEUPQfcADeomCpLzj5kNtYSSNEC
	HmsiaKQ+t1PL9+Imxv1MoyjEgcjKuEQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-FKOnyOO_M6GuaWnsVhWLZg-1; Mon, 02 Nov 2026 16:16:39 -0500
X-MC-Unique: FKOnyOO_M6GuaWnsVhWLZg-1
X-Mimecast-MFC-AGG-ID: FKOnyOO_M6GuaWnsVhWLZg_1793654198
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48df02f2bdeso78661f8f.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 02 Nov 2026 13:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793654198; x=1794258998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/8iyy4HZ7/aVXuOHPUsPysy0WI5/Kcxb2nLLftofoI=;
        b=mRoRphNCc5EDqIG3O9yS8UKXrP7lLO10tQ8sfEVwbSPAqWeJgr08Qbd/Iu6oYjK/cp
         bsiYp/F25uRBVeYkKH37kk0bFRO9ahS5PH8WWTyJVifrGB7BIbMK4kQfbihagUzQd4TP
         XSMWIArNOmOyHHAAMUwNhyTF+We1TMivCPZkiXKhO7cBwTEQGLfTbcn1Cr+oKaYcTVXm
         oLNN8SBwjz+JQE0jipluixQXRsFAQyhlpD9MwnUnxiCdR21rYJyKPKYoxTc+fk6ga/QU
         tdb09IeA6v6VGU/3+/+imE75Q37asgk4urb7vVgR+Xxk1ya3aWYYL//LEdiaDSqTGEZG
         Bpkw==
X-Forwarded-Encrypted: i=1; AKwUvBy8TSOEVvhZ1Et0wAr5GJ8fROR8dpnoP0uFSOeV+pf8HIc73sKy616FpVgvX2lWyxi9sqhp8hTBp97jBDVYSQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8Yyq983ZkjAmdCXLf0S664QvE9J/1y95PnAp3vE291kFQ1oiRN
	X782KJLyjbP0bO30+SwgvnM3hReOR2Lmtk6/odr4wC1eEIjfjKO8SL2qw7PgR4YYD6j2BAvzPZc
	Sf516FQ2J0cXlKoegpk/KojFW+GsXKGw7ERiovBA/Fx+XfWl4OVJobkv9DNTsmAaSixaZ
X-Gm-Gg: AYBFou04pDhlHBYMDNwnUvUu2uBlH9PC5XZyrdOEe93rdbVf2l12A1BN/KIIIU7cVhV
	7yDw4wwbu3Z3iBWPV+3GVUjlGC91PQZYcjhurVGC4FFI2JW7oqxY9wgWCEPEEK2KjM2hT3w1VVs
	ZAw2o8IgGLznT3METpUIfJU/NGBbssTQaRYllTgjIFcyNzMG2M3xfya9PhwwnkJxixnXduZiZ8t
	qhtbdI8pUOLtnG2IMStlcnutf6X8lUHU8FnohcSaa7HxpJrEMcwF3iIB0spJx2o+Pw1CnhCmb7g
	+/jCRhnEyhnwlDTkCkDl/dK4GcRN9RfulbQsiAw5iSWw/jgbeaur69Otp+ZT6IKpO2NWLQYxgk3
	zSJqQPl1Tzyq+7r1cnGCdTe+iOF3iP3dC46v3mdVNCTO/qlci1/KDz3xsgSwlCq10eT9ZldEJIC
	HkDNa282IbacH6dg==
X-Received: by 2002:a5d:5f48:0:b0:48e:6ff2:606a with SMTP id ffacd0b85a97d-48e6ff2609dmr27631589f8f.6.1793654197964;
        Mon, 02 Nov 2026 13:16:37 -0800 (PST)
X-Received: by 2002:a5d:5f48:0:b0:48e:6ff2:606a with SMTP id ffacd0b85a97d-48e6ff2609dmr27631544f8f.6.1793654197560;
        Mon, 02 Nov 2026 13:16:37 -0800 (PST)
Received: from localhost (119.red-83-42-172.dynamicip.rima-tde.net. [83.42.172.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71baa1b3sm20838703f8f.56.2026.11.02.13.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:16:37 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Mon, 02 Nov 2026 22:16:20 +0100
Subject: [PATCH v2 1/3] clocksource/drivers/nxp-stm: Fix max_delta overflow
 on 64-bit platforms
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-Id: <20261102-nxp-stm-fixes-v2-1-8ca2706f30ef@redhat.com>
References: <20261102-nxp-stm-fixes-v2-0-8ca2706f30ef@redhat.com>
In-Reply-To: <20261102-nxp-stm-fixes-v2-0-8ca2706f30ef@redhat.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, stable@vger.kernel.org, 
 Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793654192; l=1278;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=DVfNt64Fa2EP/J0U6rHzSmiL2wOHXcUfdf87XnRZfSg=;
 b=l9hNDdzUrhma71aFw5r9/uBmIB5COcdfl4Gq7cRYpas8co0jiLEqNrhksseawGF7HVyaMLcJR
 wxiPwGkenjpCPQfWwh1t6b2mYj7Q1sJtwNbsSjje6VTqWdOIE/SHRzQ
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lNDjo7HgiJ3rcHdUPZ-gP-eS7FrPnxKjNzOi3d6IOqI_1793654198
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The NXP STM timer has a 32-bit counter and 32-bit compare registers.
Using ULONG_MAX as the max_delta parameter for
clockevents_config_and_register() is incorrect on 64-bit platforms where
unsigned long is 64 bits, as this exceeds the hardware's capability.

Cap the max_delta to 0x7FFFFFFFU to match the 32-bit compare channel
width, avoiding potential timer event misses or unexpected delays caused
by programming an unreachable compare value.

Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")

Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/clocksource/timer-nxp-stm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index 6fe098a4a33f..ee249fed1b91 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -346,7 +346,7 @@ static int nxp_stm_clockevent_starting_cpu(unsigned int cpu)
 	 * minimum ticks = (rate / MICRO) * 2
 	 */
 	clockevents_config_and_register(&stm_timer->ced, stm_timer->rate,
-					(stm_timer->rate / MICRO) * 2, ULONG_MAX);
+					(stm_timer->rate / MICRO) * 2, 0x7FFFFFFFU);
 
 	return 0;
 }

-- 
2.56.0

