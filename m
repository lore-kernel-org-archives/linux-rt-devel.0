Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959929;
	b=kx4LH53ueT7mmjV7g6HBc10IJB2Fjem/Bmomdw7xurpcxNEK/Dt9OtAQEF+R2m5vitoS
	 0ej99NYHzRFBjhkZOfGlAiOTneZaWMnjIKyj+bN9rCk9wXZBIV6Immd2i1dVuw7GYRjhJ
	 wSYVuybdCD5mWUr0pCLpNaFfT3MBNVkpcSyaePj4VuB4JF9jcsscFWtIi17VyznuH8MOJ
	 gIUbIQVI/jESRo5aVnXwNlPg+ffgvnZ8nF7yz+OSTCOSe43dvYq6sbj5ppexgPGTvzg4c
	 vwT4pbr24VszsNvcsUaS4ca8FWGWRdK81x+I7XfxlXIbnm3eM/NEAOqwrj5PDaxgYnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=YYOHGdo2Uum+V1fQIyTYxRpM9Fq04ij2FJz0fEEop/4=;
	b=o3t/s/Z61gAeVqroaNAp0eqPz4g8eLER/sZMtBkoNweEx4ivF7DnG2WWsOd1+QFe4ZOB
	 IBRbqgwgh5uZaHoTG06qycfWzPR6rqMsdDsK7VNT4YrziT8+N6HASG4zR7shomRCHEKaM
	 O6jVmD7ZHQyL5OW0TjaFE8AupnlxjrTGNqrtb6c7kIUB5QreiRpdHXhyW6BrOR+Fq7tfI
	 g0Kdd0Pem9hfry2UyU6rwlZ/tfqv+r5HZD5hpNpdNx0kT/Dpx703DHAhyyQ6h44vzqo5U
	 B1gIGJjIHXX+O2Bu8TbrdwyiV0WI/ieI0hYG+39UTi2oe1vojLbSlQ7HBEAEkF6nkeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kZXHJ2M+;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B4606A330
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Nov 2026 23:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E1B4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kZXHJ2M+
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ed11653a91so1711645ad.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 17 Nov 2026 15:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794959928; x=1795564728; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YYOHGdo2Uum+V1fQIyTYxRpM9Fq04ij2FJz0fEEop/4=;
        b=kZXHJ2M+cSA1BJH+S7o+S1g9ny7ZM7m2A6eLb5w+ZjLPV3zYbdZiKf59U0MXyYfN3f
         Cwb1rtYYS70XxY+9m64PW60nJNSCvG2Pww23Woym4mxSiGjEU4vCn+WUmyqo6IgEhXUI
         rAzExnXQky2ILMtQRYXXwh/xPUQoTFf2cTbWW5q/XqVLdEy6qMFfSxIzw0iOSg72Ih5O
         X7jEYjQiAtimxOw3IzwUYpsR36GVVuPnqyaAqh5luFBaNtbZmT6uqQuuTzKpNrJVOFNi
         eO3M/ZWCuyKJWd+RdYcsD5FQ7sbgtA+3+dAnxnieSFzr+QhHI7VLQnOLI+/vZ2mYXaYn
         N6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794959928; x=1795564728;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YYOHGdo2Uum+V1fQIyTYxRpM9Fq04ij2FJz0fEEop/4=;
        b=kqSOAv6EJWzoLSFE38vORIvUHE+KkXAyv0YphFnP4y+qe7o9Mb6EIkHYWVC4aDhmPj
         0PDQtj1LNTsHaSikAYKP+XZsKvOi0tAA4QpadaLNLOy4iiDp5ZPg6pyPsHHkP5632cl+
         s22NNqz8SKcVIzW/W/rDnywEwNW3Jtkit0+OIozD8de1pCr+kGThvKAz5mfaIOvE7A3n
         jqV+kGnWiya630UiIIyxJhP8XHr2HtpEy4dubHAPUvDt4rcQJNOx2jcFj90LlnTqBfd7
         teRiBi7JigMASqzB1umeDRea+/FLYoATN+voY2a8P5DV4gB4KEnogVAdBUF/RwzFoFfI
         Qnww==
X-Forwarded-Encrypted: i=1; AL+hErHMEolgONLFQqAcDIdYqaFP2/pwdD6K35myRcNvvnaWZundHj1e1IJDXUBsLfv3KzOeXydXvllhl+2NC5jUfA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9WlGPUBT9YP0OdbpPewhX4POAbLhh27k0dn2e+LvXzRfyMPyog
	CNXPvFllypzB21gwprisMI03BQrK2arYX0ookluFP89jr5tIK0nuIB/UqqwyTIskh/M=
X-Gm-Gg: AZFdTZeEPvavjj94hOeZP5BdAsUk39lHqwyWaAIRJv9pnpSWnNzOV4nIOW6FtCjsJXi
	330igm3MUWchIgpI6pEXjq06uVrn4u1zSSO1bk0e2IUIsl/cLxrwb+qeDUsf/BHz085cKeXhbnI
	8joxMB8C/bRHueAGVFWVn76h/dujWDvZ441TuxjmV+GRc80ljO1M+4ce+TUu2dTSM96CvYUcizA
	V35yPqRF/ukdiLPEfxglhqGFRfQA9yEBSFpy9n9KKlvR+lXR3iAkYwiTZSMVoEndCxsPAS0+fE/
	BMbI2iaQ3+AlY8k0yR+Ol8xbqrZJMeer53L8kLExIyVMHJs89TovMMmocBRgMyS+kgwvvQQgGPA
	/KgrbIrR+lE180IP4UZ6fF/I7AKGEvKzgUAsxvGOS7mQJM6XKeO+xqtiMaB4zCImSW7FQe7de0q
	mO6SAk2OpIzB2nxlBcKrBZI/Bkng8ZY63SoYVvBom/H8YUOIzg2JumCoS8gYJpdqzH9Yz3t4OHQ
	iCRRasYzbpCclrUGRMW/tXz0+O1gljRhxPYzVrTx+/q6pjtNb9T8PK8n06gjfxr5VX+eIQCwzNJ
	pO+CRj9vHT49+CfxjXE5zxa2
X-Received: by 2002:a17:903:94b:b0:2ed:56ee:af8f with SMTP id d9443c01a7336-2eff720def1mr8355735ad.2.1794959927638;
        Tue, 17 Nov 2026 15:58:47 -0800 (PST)
Received: from localhost ([97.126.173.69])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2eff627f421sm3482425ad.57.2026.11.17.15.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:58:47 -0800 (PST)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Tue, 17 Nov 2026 15:58:39 -0800
Subject: [PATCH v2] cpuidle: psci: Allow domain idle states in s2idle for
 all CPU idle states
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-topic-lpm-psci-domain-callbacks-v2-1-744884105846@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAC7q/GoC/42OQW7CMBBFrxLNuoPiEBrCintULMbjCQxN4mCbq
 Ajl7jWhB+jyS+//958QJahEOBRPCDJrVD/mUH0UwBcaz4LqcoaqrD7L/dZg8pMy9tOAU2RF5wf
 SEZn63hJ/R6Q9dSW7xnXbHeSVKUinP6vh6/TO8W6vwuk1+0cEud2zOr0xsBQF2Q+DpkMxN5saA
 xt4tS8akw+P9e5sVvjfz2aDBmuqG9fuuOWmPVp69GqDbLILTsuy/AIKK0S/DwEAAA==
X-Change-ID: 20260831-topic-lpm-psci-domain-callbacks-a8af0cd7df35
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Christian Loehle <christian.loehle@arm.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Scaria Kochidanadu <s-kochidanadu@ti.com>, 
 Maulik Shah <maulik.shah@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5783; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=guTL8dYKPlJDgX26UnFRsZQN38nxU1WkErfhyeEPhdM=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBq/Oo2kY6Xp4ijMAORZ44kIfExylSsinOdQLrlr
 I1XRTaDEm2JAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCavzqNgAKCRBZNxia0/vG
 ZZ5uEACN+j6ErUSQKd6/XHskcSMq5MnnSxTmTrPatCH4tYKEUJNPOrG5zWSTcTLTAZdPgn5VgDf
 Ig0T8XJpi7ayBiooduqu9FnhalqW2uP7kXccZNkMf5UOLYrL5y9TutrJdBRdFmPWwRYr8A0zfSS
 qCI5xiNbiBU7ZJSAIQXVq9mCrbk3TOC552QMPGk5DmXllVNDN4pICYbPeA8QhyhKQH9Df0KaebV
 E0g7ZZMiCOVGKloVt0xqOfGUviNq9vg71x1gnXfRqXK8XvXwQmSsPnxc4hw5F09rUqPps2BrOqz
 rgJxV1C5V43JTTIkm4ki2UzxUzedu3bemeyPPGY0Tr+cSdiv6o79/pFzsQku+t6kStelDqJJmwN
 QstYw3eXWJXKgPqQtTBTyK/cfm4kfXxi7gJKjBvG6BNsBc01u15bq6/KrKufKmS/4POGxsuSjJC
 t+d8LRaZ6cVa4BEAfIAsUCxyoLvEekEcgdfC3eMx2CoWcQO3VmGflHZ/bO9Q5IX2pe6/aw1tO40
 jNPUMuEzXSoJn9WfrHQUz7VzVypheFW/0+amYr2zsUyWU2NWRzsM80ZVSrl+eQJNidczBpVYHNP
 tHd2wXP7x3DzyQ73TI3JPOjZWWB/AiyLlHXPMpl5enJd+en/cwBY2SoCTWKE/BzbdtNZwshBFFh
 oyKgJP1Zhj/tRig==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

Currently, only the deepest CPU idle state has its ->enter_s2idle()
callback set to the domain-aware psci_enter_s2idle_domain_idle_state().
The other CPU idle states use psci_enter_idle_state(), which bypasses
the PM domain entirely.

During s2idle, the CPU idle state is selected by find_deepest_state(),
constrained by the CPU wakeup latency QoS limit. If that limit excludes
the deepest CPU idle state, a shallower state is selected, and the CPU
PM domain hierarchy is never powered off. As a result, no domain idle
state can be entered, even if some of them are within the QoS limit.

Fix this by assigning the domain-aware ->enter_s2idle() callback to all
CPU idle states, except WFI. This is safe for s2idle because:

 - The genpd governor selects the domain idle state in
   cpu_system_power_down_ok(), using the same CPU wakeup latency QoS
   limit that constrains the CPU idle state selection, or a stricter
   one if a device in the domain has a system-wide resume latency
   constraint.

 - There is no idle duration prediction involved in s2idle. Both the
   CPU idle state and the domain idle state are simply the deepest ones
   allowed by the QoS limit, so the genpd governor can't override a
   decision made by the cpuidle governor.

The domain idle state's arm,psci-suspend-param is a composite state that
overrides the CPU idle state, so the exit latency of the domain idle
state must account for the complete composite state.

The regular idle path is left unchanged, so only the deepest CPU idle
state can trigger the selection of a domain idle state, as the domain
idle states are assumed to be deeper than the deepest CPU idle state.
Extending this to the shallower CPU idle states isn't safe. The cpuidle
governor may select a shallower CPU idle state, based on its predicted
idle duration. The genpd governor isn't aware of that, as it only
considers the next timer event, so it could select a domain idle state
that overrides the shallower CPU idle state with a deeper composite
state.

Suggested-by: Scaria Kochidanadu <s-kochidanadu@ti.com>
Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
v1 assigned the domain-aware callbacks to all CPU idle states, for both
the regular idle path and s2idle. As pointed out by Ulf, that breaks
the current contract with genpd for the regular idle path, since the
genpd governor isn't aware of the CPU idle state selected by the
cpuidle governor.

As discussed with Ulf at LPC, this v2 takes an initial step by limiting
the change to s2idle, where both the CPU idle state and the domain idle
state are selected based only on the CPU wakeup latency QoS limit.

This pairs well with Maulik's series [1] adding support for domain idle
states that are only allowed during system suspend (system-state). Along
with this patch, platforms can describe several s2idle-only domain idle
states, and select between them via the CPU wakeup latency QoS limit,
even when that limit excludes the deepest CPU idle state. There is no
build or runtime dependency between the two series though.

[1] https://lore.kernel.org/r/20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com
---
Changes in v2:
- Limit the change to s2idle; keep the regular idle path using the
  domain-aware callback only for the deepest CPU idle state (Ulf)
- Reword commit message, fix incorrect claim that no other CPU idle
  state has ->enter_s2idle() set
- Link to v1: https://patch.msgid.link/20260831-topic-lpm-psci-domain-callbacks-v1-1-4a47d95c9c79@baylibre.com
---
 drivers/cpuidle/cpuidle-psci.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 0187d6a9096a..01a571479e5c 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -250,6 +250,8 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 				     struct psci_cpuidle_data *data,
 				     unsigned int state_count, int cpu)
 {
+	int i;
+
 	/* Currently limit the hierarchical topology to be used in OSI mode. */
 	if (!psci_has_osi_support())
 		return 0;
@@ -261,12 +263,21 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	psci_cpuidle_use_syscore = true;
 
 	/*
-	 * Using the deepest state for the CPU to trigger a potential selection
-	 * of a shared state for the domain, assumes the domain states are all
-	 * deeper states. On PREEMPT_RT the hierarchical topology is limited to
-	 * s2ram and s2idle.
+	 * For s2idle, use the domain-aware callback for all CPU idle states
+	 * except WFI. The CPU idle state is selected by find_deepest_state()
+	 * and the domain idle state by the genpd governor, both constrained
+	 * by the same CPU wakeup latency QoS limit. Hence, if the deepest CPU
+	 * idle state is excluded by the QoS limit, the domain may still enter
+	 * a domain idle state that fits the limit.
+	 *
+	 * For the regular idle path, only use the deepest CPU idle state to
+	 * trigger a potential selection of a shared state for the domain, as
+	 * the domain states are assumed to be deeper states. On PREEMPT_RT
+	 * the hierarchical topology is limited to s2ram and s2idle.
 	 */
-	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
+	for (i = 1; i < state_count; i++)
+		drv->states[i].enter_s2idle = psci_enter_s2idle_domain_idle_state;
+
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
 

---
base-commit: bc71431221f5ba8bb33918399552636e059c2c45
change-id: 20260831-topic-lpm-psci-domain-callbacks-a8af0cd7df35

Best regards,
--  
Kevin Hilman (TI) <khilman@baylibre.com>

