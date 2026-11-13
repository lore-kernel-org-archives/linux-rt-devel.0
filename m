Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=49.12.199.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578644;
	b=ZU1kN8rPZCp91cjI74Cs8Mr77o4OHtHryyRzKtPGmmdnma1aCUParpgtN9Zj82BxWW0t
	 wA2mKvPqLXLnw+PFkg7hKqMEwiFjb4G+ksmeC+Lmqb0MFm0/ZnxlhdNMMP04F/NrTGl7Q
	 ZNSc7i66+nYG4fHDNe4aX5edhXc0vjUZ7BsncdBju0Eq77QSfTjGNB3p8DP/RqgRYJrxE
	 SQksCjb6eLnA6muNXLex9THBPtB5PRdugXdvZvFqU0NiBVqnB/I924RsOG0aJKPS1G21M
	 9lqY9z3OJFz78PJRieVYzhAc4M2CxZ8FRM01t8djWoyy+6K2PyI7azKaV3z/HznB5HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578644;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=muqCZtCnODx5xWlYCZnvE31S5sIwWXI83ApgORpaH/4=;
	b=E8HXVn42By4doCMKaCZJ4I6kROgHM+lhwgqbUdqkdK8XsMGo0ORTgUAq9PKSwzlXkxe0
	 BIqFrvQ8P6JGepJkEiq7V9bjgSBOdcgNw7WBU9aKEvi3E2JjtcOtJUv0LaCZLkpvBjD0e
	 8ZgO30SX1hy1rHxe2YunMl1r45XO6blpc/vcjVgupv0pn/md+z5OciRr6u/rbN1qpGrW5
	 3RDe6GRY1Ya7acj7TBkAHc0O9Ka8rbfhJ86mefUacMgOOuoYxVqrm1L2lcIJEqagBjBHk
	 WY9UM/uQTmJi4otNpIzJC72tSGQ3Ub2q3jBMbXyau4sB10KDdkhgz+8dCVMo+g2kd7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=monom.org;
	spf=pass smtp.mailfrom=monom.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=+rkgeThX;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=RiuYxJL+;
	arc=none smtp.remote-ip=49.12.199.46
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2178606A32E
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 14:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2178606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=+rkgeThX;
	dkim=pass (2048-bit key, unprotected) header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=RiuYxJL+
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=To:Message-Id:Subject:Date:From; t=1794578633; bh=muqCZtCnODx5xWlYCZnvE31
	S5sIwWXI83ApgORpaH/4=; b=+rkgeThXaAz2kLQzPJ8WQNCG4x5vgf6u+qE+NaSVb+VD6twIM5
	+Ca4WG7iL/16ShVRMIJBNiuIZEZbs0b6sWBg==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=To:Message-Id:Subject:Date:From; t=1794578633; bh=muqCZtCnODx5xWlYCZnvE31
	S5sIwWXI83ApgORpaH/4=; b=RiuYxJL+OSOJ8NfFm37Je3NAvoyEx5tquNTpNknWcxT4F4rHKL
	3Zjv4H2LL3VwFJoHoseLLAUtMpAFOYV5VEe2+gX7pfLFVzc6DT0jEXcnxmM4XCQ9IDK1TLxAOEe
	JiB9L6ZcQhxotCAxNqd16dcHaVo1BetGlfQHLsGdnqcs44YYV2Nwe+HOlTp3wabVfR1RuLU4wJE
	n/lGrK/0d/rKCsc2lmnQi+VeaL71+YH1MdwV4iGN3I46y2EcE6MEDlwSjndgMvIIrzzqOKRbADI
	zq/cvAsMaN1Bp9lPuuBRn2N4fVF/b4ifucF2ssGIs5UWiMijNiML31xvwdVz4/yOztA==;
From: Daniel Wagner <wagi@monom.org>
Date: Fri, 13 Nov 2026 15:03:50 +0100
Subject: [PATCH v2] rtla/timerlat: Lock the memory of the user-space
 threads
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
Message-Id: <20261113-rtla-mlock-v2-1-14382f140da0@monom.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4XM2prOIA9Z+R+GRcEBqpSaFhsN4
 d8tuHV5knPPXcCz0+yhShZwHLTXdopAhwTaQU09C32LDCQpR0QSbh6VMKNtH4JUVlCHMktThjh
 4Ou70e49d6x/7V3Pndt4KmzFoP1v32d8Cbt7fcECB4oTlucwLxIbkxdjJmqN1PdTrun4BiIXVN
 7YAAAA=
X-Change-ID: 20261112-rtla-mlock-2a572f10533e
To: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 John Ogness <john.ogness@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 Daniel Wagner <wagi@monom.org>
X-Mailer: b4 0.16.0

With -u, the latency timerlat reports runs until the measuring thread
is back in user space. Nothing keeps that thread's memory resident,
so under memory pressure the kernel reclaims its code, stack and libc
pages, and the page faults on the way back to user space count as
latency.

On a Raspberry Pi 3 (PREEMPT_RT 6.12) under stress-ng --class memory,
timerlat reported up to 40 ms for the user-space threads, which took
283 major faults, while the kernel threads' latency stayed below
1 ms. cyclictest under the same load: 133 ms without -m (mlockall),
0.9 ms with it.

With this change timerlat reports 0.9 ms for the user-space threads
under the same load, and they take no major faults.

Lock the user-space threads' memory before they start measuring, as
cyclictest -m does.

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
Changes in v2:
- Shorted comment.
- Moved the mlock up before the sched switch as suggested by John
- Link to v1: https://patch.msgid.link/20261112-rtla-mlock-v1-1-418986711b20@monom.org
---
 tools/tracing/rtla/src/timerlat_u.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
index c80edaf07b00..5e7a23fb9fc3 100644
--- a/tools/tracing/rtla/src/timerlat_u.c
+++ b/tools/tracing/rtla/src/timerlat_u.c
@@ -15,6 +15,7 @@
 #include <pthread.h>
 #include <sys/wait.h>
 #include <sys/prctl.h>
+#include <sys/mman.h>
 
 #include "common.h"
 #include "timerlat_u.h"
@@ -37,6 +38,13 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
 	cpu_set_t set;
 	int retval;
 
+	/*
+	 * Fault in and lock all memory before switching to a real-time
+	 * priority, so that page faults don't show up as latency.
+	 */
+	if (mlockall(MCL_CURRENT | MCL_FUTURE))
+		err_msg("Could not lock timerlat u memory: %s\n", strerror(errno));
+
 	/*
 	 * This all is only setting up the tool.
 	 */

---
base-commit: ee83899302a0457a3ba47464a13e8682bd7ba27d
change-id: 20261112-rtla-mlock-2a572f10533e

Best regards,
--  
Daniel Wagner <wagi@monom.org>

