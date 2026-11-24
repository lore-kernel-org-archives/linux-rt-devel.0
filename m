Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529540;
	b=n68H6PmR/z7Y/KmCfe3kO8Q67o6SBOR/DP8nCFZupyE8GbR3Kum+ejsVlvBxsbcA1nTQ
	 v7knbJigg0YppRx1D8Ihc+kzgSIKKOtQXcZGVBAYSX6Xi5IWVv+dkWdjXhoUY03cd78SU
	 YlTuKDEP2wqksjEAqO2qO0CZ/fRJRIoGZATzOtCfedKmwRt/QlIni/eFUDMXnhk1nrr9n
	 2gVqz0wh5KLB8vjT1ymxC/ux6khyHEsHI5GI2fLjwFV+Omz/O6WZHkggRXeGPqg5CPBA7
	 OP9ggMjwyWSoUApNc9fZRxXVYB/MhiOce/P4ObVhpqaP4Vn7rwEtciIjk49SB0iNOCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1xGMs6jT7TfzD1rWb/wp0MZUHeeMb6G/nblIX2zqKoc=;
	b=F5cD/iRP/eQ+TNez+hxLPfGJIPMkgM30/GeLDgqEQIQsO4nuZufYkkPbapXDeU3vyXVn
	 BmXePC1b5+uRr1QYWczyOS6LmWOknEoTjq7rB/a3+4KC9utc+tJxxt9au5qB38E2kD9MY
	 V+LANEbSuzMUn94mQkl1SnT+YTAALfl4j3NfB4mrsgN0w+252XA6d9BO1sR/tiWxlAqwE
	 FUfc0hdvVMgc3JTZGZTKYWE+oXsZmS+aHObBcXZfTgAmkDvTOFR1kxUsVuiLbCMsdjPGY
	 KUhDFEbbi2+NlDwTOkyoRdur8jp3Jf/MeF23tgFLmAKPb8nd61fpmMVIeseRJkitfCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=N6pnTz8L;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE57606A334
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 14:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEE57606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=N6pnTz8L
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b8b20b2538so5394306a12.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 06:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795529538; x=1796134338; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1xGMs6jT7TfzD1rWb/wp0MZUHeeMb6G/nblIX2zqKoc=;
        b=N6pnTz8LSwjYEfuo/CCJ5VYI7g/yBR8L1Tj1MUSrHQjoKw99ie5kBY+Es1JquPn4AM
         /Ks1gVQnzMdW4DlxpI8ML2lywkdtmCDO5e47LZ/nxwWN69zzKQXU8+Qg8wxMSNhez98B
         SfqasMy+U80Jr2nLPaiplASHM2PSQb4Buitbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529538; x=1796134338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1xGMs6jT7TfzD1rWb/wp0MZUHeeMb6G/nblIX2zqKoc=;
        b=tOElHIyOcZlRkF2iE61PRXry6cSFTPRAEv1TJMQdmGKybnuRDvcLwk2hJkiJGbmf7e
         8dyyeZ14n/ojNBF3XSDTbqCqP0BYniEhdACTJcoupMYoB5EcWxFR4JrIhMIH51r5prXl
         185rmhn+Vy1MjD12dhHl8J0xamKmgKHQyToneEhRovbLgiNArpiAFO9jKR6Fn1tuUr/j
         odgbKCUWVTNJM3RExx4F8WZwqROE5Hsr5nyWGBxoyp/pKgDXCbd6Aa9C9+G/dOugYjOk
         3zAE1TqJ1ZgAiBTtZldBGgJQh+aqq7WQsm9LRAnjVWSv3a2g4lIFAeGV4XxHsv3FM1ms
         uhnw==
X-Forwarded-Encrypted: i=1; AL+hErH/hP9FPRuGmG7TLq6JMkjfIhyw3C8vPYtAkR0X9JtaAls2jkHe8MrErE6FggttXQgq2L1zQ+qttgSgVSfhmg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+18N1MSgagWCjrBfr7nWloPLpzSeYO52w/5rnKT6lTqmryVf8a
	jnB22jfYLphTGFgKJDSJ2L8YU7LuXXbEaPPmxpmFdcT/PdfjWegLWmsyBGP6Ku+b0w==
X-Gm-Gg: AZFdTZd3pQmqmCtsuFB/KcJFuRGLo+vDZ9iEXcrlkDcKdKyd1Vzs6/6yRIM789ACPI1
	0DLnxHsKHQbf6HJ9KbDP6hOha5ZaziIOqd7LHTkGYKzYHQ5oNDtLKOLZnZ0kGHr2z93HQA5LXJJ
	/UoBn4/Zsn1yBSuoglu22ok6A/j03IOeYFfp4OoNE1jUDJmZi/eYlTOy62bGo3GWaH7SCBuYB3U
	CN1ScBqP9pr4DXQac+45m+VW9jjhogyBF126fSFAO8AxTuSdnIIQ03217lklEo+hEcypp8Y9mpG
	fgTZZuMqRXCe4x5Z+olIsU18x2Wp5pgv+kJj9q8mvJteR4u9QzQE3EZ1QkrT9SQrotsG1NjSdP7
	bZ4fNnKEq0E69IIjKaH23Y7DFVKvdGIE3HeDBSf/Jyljx7cDJDKUm/Hf+Cals0wpiUMfq/iUI5I
	KBlZb0n9mvYXtPzAbIU0gKLQXgO08fiydZzc9+87GYY6DujlGzQ1Lav9PgxY3YR9CYK+5UaJ07z
	ddLZPWL0eaOWB1uMcX9SViPGcf5e1MS/zCnFSEE5VznpL0fHrZ7rEQI9AZZAAGidUuy15z74/4C
	fCO6CnjJLwSsmcohjWDFE5Iq6h1TdTHMM5ZyqU3dOnhPZy7LJF+/5Qqo8UTb3ikKtFO2hUzGIY/
	j0V0M+Ir1HYMUwLheVkFO
X-Received: by 2002:a05:6402:1596:b0:6bb:6c8:c4d2 with SMTP id 4fb4d7f45d1cf-6bb06c8ce30mr1085338a12.31.1795529537654;
        Tue, 24 Nov 2026 06:12:17 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba7b9570e9sm5032739a12.36.2026.11.24.06.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:12:17 -0800 (PST)
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
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	linux-rt-devel@lists.linux.dev,
	Victor Nogueira <victor@mojatatu.com>,
	Edward Adam Davis <eadavis@qq.com>,
	Po Liu <Po.Liu@nxp.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com,
	shaos <shawnq1@163.com>,
	sashiko-bot@kernel.org
Subject: [PATCH net v4 0/3] net/sched: act_gate: bound the cycle time and refuse schedule entries shorter than 10 us
Date: Tue, 24 Nov 2026 09:12:07 -0500
Message-Id: <ACT-WEXM.v4.r0.20261124074514@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

An act_gate schedule is armed from TCA_GATE_BASE_TIME and
TCA_GATE_CYCLE_TIME, both unchecked u64 attributes that are read into a
signed ktime_t.  A cycle time above S64_MAX turns negative on that read
and the cycle arithmetic that follows wraps.

That arms the timer in the past.  Every expiry then recomputes the same
past time, so the timer softirq never finishes and the task that
installed the action spins until the watchdog reports a soft lockup.

A schedule entry of a few nanoseconds reaches the same state from the
other direction: the entry interval is the period the hrtimer runs at, so
the handler is always behind its own next expiry and the action holds a
core for as long as it exists.

  1/3  cap base_time and cycle_time at KTIME_MAX, and make every
       start-time computation saturate instead of wrapping.
  2/3  require at least 10 us per schedule entry.
  3/3  cover the refusals, the largest accepted base time and cycle time,
       and both sides of the interval boundary in the tdc action tests.

Edward Adam Davis posted a v3 that capped cycle_time at S64_MAX and moved
the attribute to NLA_S64.  That refuses the reported value but leaves the
invariant to the wrap: base_time is read the same way into the same
arithmetic and stays unbounded, so an accepted pair can still compute a
start the timer was never meant to take.  The type change is also
unnecessary; S64_MAX is a fine range for NLA_U64.

Alexei Starovoitov traced the stall to this action on the syzbot thread
and sketched the saturating arithmetic used here:
https://lore.kernel.org/netdev/DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com/

This series keeps NLA_U64 for both attributes and bounds the computed
start time rather than one input's value.  cycle_time = 0 stays accepted:
it means "derive the cycle from the entry intervals".

The 10 us entry floor comes from the measured cost of one expiry rather
than a device's frame time, and 2/3 states the margin it leaves.  The
100 us floor proposed for taprio was withdrawn for narrowing working uAPI
and for a margin it never explained; this floor answers both.

Changes in v4:
- Reworked as a three-patch series on the current net tree.
- Bound base_time and cycle_time at KTIME_MAX, keeping NLA_U64.
- Saturating start-time arithmetic, shared with the catch-up path.
- Minimum entry interval, with its measured cost and its tdc coverage.

v1 -> v2: reject an out-of-range cycletime instead of clamping it.
v2 -> v3: move the range check into the netlink policy.

Jamal Hadi Salim (3):
  net/sched: act_gate: bound the cycle time and start time arithmetic
  net/sched: act_gate: refuse schedule entries shorter than 10 us
  selftests: tc-testing: act_gate: cover the new cycle time and interval
    limits

 net/sched/act_gate.c                          |  45 +++--
 .../tc-testing/tc-tests/actions/gate.json     | 189 ++++++++++++++++++
 2 files changed, 217 insertions(+), 17 deletions(-)

-- 
2.43.0

