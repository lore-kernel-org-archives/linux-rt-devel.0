Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529547;
	b=d7Syz/6Xlw45spZeeiz2BV09zT5roaVKv+xI1SHqp+iTbD9bGRZOUYzEceR++mFla/Rw
	 xSw/nPozPFtKTPNPjomT0GcPmVwAh98nAAY45QUwp9UOhPV0+JjiJbHbx/Hm9ZA4dH37a
	 lLuSMIZio57altQsf9oBquQZT9dkJ6/0g73RKOlc2HyzmmeTHkxQDJa3Pyr718qfX6kWq
	 V6MZo3YoLNazKWHsK7ZNOVKpEugP8k0MiuRMbe894JvVYcrNxsOTHJxwvDWxAptImQ2qy
	 j1sxDbJW3yQrFu/x4Ymjvw8pq9V9LtNWJZgsbHCzxtzI/GXDjNL2DaCsMPOeHpLE/ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=phUozZ9UmERABn/pPGUaQNiwGGv5ztLQHvi9xNV+FYI=;
	b=TxFFerabO6sa3wTZemmNm50UWWcNSksSyK9d2oR8n2YC7rBYt/YgjWdt57JxOMdI9LUz
	 VZPtNDxiThNfKYF9HxDcmGeL42qEmKtuSQ66diOMwuRQZTGkCFY3Ay83KUKB0bfG6hkha
	 9ptMbyMiQ7nSOPxI5x/KlXwYDGU++PjyaCU946zi5M5DnYVOZX3zbXlyt8Rb01+3ehe7U
	 PENJrUEnMZ+Z2VTYqViyisqTPHKJCIMwFyGwIw7B7NjgjFNx1wXqO9QwIhldIxHYMDpou
	 UPT+kT+FenyZ2hcU33CLVLsoVS5eOae3PeilqtS0NybNIzz4gC4bHkNQtj2sie3fbxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=t10+Ao4C;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A62606A334
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 14:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1A62606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=t10+Ao4C
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b86bbce3d1so6121601a12.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 06:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795529545; x=1796134345; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=phUozZ9UmERABn/pPGUaQNiwGGv5ztLQHvi9xNV+FYI=;
        b=t10+Ao4C8B5Qh5c+EYaFiCgAj3vPwdgg/48CyFIzZQO0xMR1GHQu+0QI751FpYI+h7
         X/+BEWV7dhQEv/No0VEkciE0dZyCaHuSwfmhaYSAOZE8DRZSGPfiuNtLEJYTCovPftal
         LQPlc7VKTuLBjBCizpIhfQhTDyREd2lrJ6Poo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529545; x=1796134345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=phUozZ9UmERABn/pPGUaQNiwGGv5ztLQHvi9xNV+FYI=;
        b=Hc35NCU34a3NE7MWsVxKRse1Q5PXIww7qgXhu0NbWtj5fM3GhSL5ywWpfvyhguKZWk
         x8KaKP01ldr6Xews4ooRbyR2cMCkoDERY7Cc4yYXdhNq1OKCrS1Hk/eodT3Jsw/B8NSt
         pm3mBuIzL9Uu4sud6X5fGW0wbCG3nvIzKz0wPAUeLMSJdRpF3vkaiTzHS3uJRJIvC/E3
         pI3vJADyutRhWWQmsLLzSRcYhhsD3dR+U3rTf+Dd6nlTnt3ri3r/obSsS+EtgsaiWOua
         VoYq+ncaBjzjAEIcfaeHBr+Tkw4Lex6OlAZTs9WVKEsVP4zUQMwl7oYrKIQY8nEHMi0K
         45+Q==
X-Forwarded-Encrypted: i=1; AL+hErH0L2Jirf7NqCh4x5ePVPr989zWOeCTwAQa3CGUoVuPCshhgexuN/1ljHbX21oNSWk00aFa7VtzT+UWG0M+sQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+LJ+lU7fLXyiSoioxwTvlSuJLtACi12RyPrbJflqLTavadL1bc
	JMbN9hczybPGb0+1iTiIP5bZG1fbamaRqd5TPxHR5GUUQxIC/mR0O13efiBis8zwsA==
X-Gm-Gg: AZFdTZc6HDLl9vwFBbAzsmjbQd1N/IXGZaRz9grvxP37+EYkrK5TuQH+xxg0VT8PlJZ
	O9KR8skce4WWV9hUvDDYjUzeGh6DsLrcDOQOs2w+3XDXFMWZJFy5Ghj52ukE3El09WsIYpyUNQf
	3xIcgH2b4xWPDrEIoQxIPDNsAT0GxVeqcfKH0b10H3xXWytr6d282x4egjIloFcORGFD6vZdg/P
	Fmbw3229l68N4803d11Gm0Nn41IG5TPlS4IQ+uQvgako+9MMHS+GLb/VG/utJoGOo57ykCqqg5I
	Ro1rGaGCCRM+1gzWXXElKRn46GAN4ucdNN76yERQd0ajr6NbDKMWCdVIg/IEt6IU3p8DF1o9/kU
	ipk9ffjbHrXz2iH2yNpOKYcfFtUwD+2nL8Ruzw6Tsy0/cluoui4FGa2qpzmn5EJ00K0dTReFbQD
	z2XmosbRDsitoJlIxtB5yJoTQql+T1F0Z+tpu5OjILWM7mVdkKCgHZfJ9QXpJmnBhZjWjClm51g
	hEXy2letqVriqVoTVdqlbsaEfH9A5HxZTPcT1nM3bHUk8fV/h6TVdTtWv88mKwjhmy6ZJ519cY8
	ZXET9KhOwB1wEIYoB2sS5ne8eTlffYbExbzQBxCt4lQg53AmjlarbGZ/C2fsxiB5hRA1PHdQ7zm
	NgdkM0JaeEmdq+t1Rl/L2
X-Received: by 2002:a05:6402:210e:b0:6b8:50e:3bb0 with SMTP id 4fb4d7f45d1cf-6ba37ec6490mr11204252a12.43.1795529544904;
        Tue, 24 Nov 2026 06:12:24 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba7b9570e9sm5032739a12.36.2026.11.24.06.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:12:24 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Victor Nogueira <victor@mojatatu.com>,
	Po Liu <Po.Liu@nxp.com>,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net v4 2/3] net/sched: act_gate: refuse schedule entries shorter than 10 us
Date: Tue, 24 Nov 2026 09:12:09 -0500
Message-Id: <ACT-WEXM.v4.r0.20261124074514-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-WEXM.v4.r0.20261124074514@mojatatu.com>
References: <ACT-WEXM.v4.r0.20261124074514@mojatatu.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a followup of commit a51c328df310 ("net: qos: introduce a gate
control flow action") as reported by Sashiko.

The issue:
fill_gate_entry() only rejects an interval of zero, but that interval is
the period gate_timer_func() re-arms the hrtimer at, and a few
nanoseconds is below the cost of servicing one expiry: the next is due
before the current one finishes, so the action holds a CPU in the timer
softirq for as long as it exists.

On a 2-vCPU guest, entries of 1 us and below hold 86% to 90% of a core,
2 us holds 61%, and 3 us holds 22%; from 3.5 us on the cost falls to a
few percent and it reaches zero by 100 us.

The Fix:
Require at least 10 us per entry.  An act_gate schedule is not tied to a
device, so unlike taprio there is no frame time to derive a bound from;
the bound has to come from the cost of servicing one expiry, with room
for a kernel that services it slower.

On a 2-vCPU guest one expiry costs a few hundred nanoseconds, so 10 us
sits 25 to 50 times above it, and that margin is also what holds on a
debug or PREEMPT_RT kernel where the cost is a few microseconds and a
floor at the 3.5 us knee would slip back in.

That is what the withdrawn 100 us taprio floor got wrong.  It refused
schedules that cost a fraction of their own interval, a 250 us cycle
split into four windows among them, on a margin over the measured cost it
never explained.  This floor admits those windows and states its margin.

The interval == 0 test is subsumed.  A change cannot bypass the floor: a
change carrying a list re-validates every entry, and one without a list
copies entries the running kernel has already accepted.

Some context:
The request that reproduces the cycle-time stall also carries a 1 ns
entry interval.  With the cycle time derived from the entries, that alone
sets a 1 ns timer period: the report covers both defects.

Conditions to recreate the bug:
CONFIG_NET_ACT_GATE=y, and CAP_NET_ADMIN in the initial user namespace
(netlink_capable() checks init_user_ns, so a user namespace of its own
does not help), in a new network namespace:

  tc actions add action gate index 1 sched-entry close 1

The action is accepted and the CPU running the timer softirq stays busy
for as long as the action exists.  An entry of 10 us or more still
installs.

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/tencent_4ED9536B0375C96183B2244CF7709768C605@qq.com
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_gate.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 4835f6543901..797562dbde69 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -25,6 +25,11 @@ static struct tc_action_ops act_gate_ops;
  */
 #define GATE_ENTRIES_MAX	1024U
 
+/* An entry shorter than this lets the next expiry land before the softirq
+ * servicing the current one can finish, so the timer stays permanently behind.
+ */
+#define GATE_MIN_INTERVAL_NSEC	10000U
+
 static ktime_t gate_get_time(struct tcf_gate *gact)
 {
 	ktime_t mono = ktime_get();
@@ -199,8 +204,10 @@ static int fill_gate_entry(struct nlattr **tb, struct tcfg_gate_entry *entry,
 	if (tb[TCA_GATE_ENTRY_INTERVAL])
 		interval = nla_get_u32(tb[TCA_GATE_ENTRY_INTERVAL]);
 
-	if (interval == 0) {
-		NL_SET_ERR_MSG(extack, "Invalid interval for schedule entry");
+	if (interval < GATE_MIN_INTERVAL_NSEC) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Entry interval must be at least %u ns",
+				   GATE_MIN_INTERVAL_NSEC);
 		return -EINVAL;
 	}
 
-- 
2.43.0

