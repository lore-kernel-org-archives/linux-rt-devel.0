Received: from mta1.migadu.com (out-27.mta1.migadu.com [95.215.58.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1D9409E12
	for <linux-rt-devel@lists.linux.dev>; Sun, 18 Oct 2026 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792347347; cv=none; b=Dkb6H2sARSL1Nw249QiIfpq17c3ASZ1zc4bYJRoQjpgC51+TyDUULpQf7Jgnle47XibCsEcFpuZ+T9kEfI4RqCDEvnCBJsfvA7j9rYzWzyxVzWZw5j+e0CD4L/tWX8C2KuQu4g0pwy6UODTIEG2C3ssW9+w52aVtOsdu2/jZ9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792347347; c=relaxed/simple;
	bh=HqmCUrjg4+06azE0v+hSyzYIgleJ2lU6GL05+/Eo0Js=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FZG95t+XUd/jSSQ3R+HBO3ccb5LC/qyDsHcc98vnUTRD4yrKMzkIKW68q5pbqblIbAtS1JC4h5zaaPVjBt3ev0aqoX7hrwfF+JN4Kaj03vgsm5vZB88l1qoUxJbJC9gpimBtsy9iEXYzbZNcTu+EWEEvPRj3bVNfITnoPx+/Hv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U87Kz5Yk; arc=none smtp.client-ip=95.215.58.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U87Kz5Yk"
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=HqmCUrjg4+06azE0v+hSyzYIgleJ2lU6GL05+/Eo0Js=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792347342; v=1; x=1792952142;
 b=U87Kz5YkFaE+p8k+zkh3ylJ4TfHde+7KsfOtSVymd7VQGPmNZA0/xsYhQxt69LR4EhCpzkzf
 rNp3gx74L3pKwSz0tnmflx1Luo9pmxS4YN8HprpkFTsvW0Oz/GWXf4fEkAuWHQYBEifJpD8TYzF
 E8Ip8Vjjp2REieC5z/pKPk58=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id 4227090cbd0bd74e;
	Sun, 18 Oct 2026 18:15:39 +0000
X-Mizu-Trace-ID: 4227090cbd0bd74e
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.6-rt 0/5] net: Backport backlog-NAPI threads to resolve PREEMPT_RT softirq warning in SMP flush
Date: Mon, 19 Oct 2026 02:15:22 +0800
Message-Id: <cover.1792345413.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Backport backlog-NAPI threads to v6.6-rt-next first, as requested by
Sebastian and Clark, before following up with the v6.1-rt backport.
The base is 4c4970859022 (Linux 6.6.151-rt78-rc1).

The existing RT workaround, 1f7514c9c75d ("net: Avoid the IPI to free the"),
redirects deferred skb cleanup to a worker but leaves RPS remote-backlog
scheduling on the function-call IPI path. In a fresh RT guest this still
triggers do_softirq_post_smp_call_flush() from idle queue flushing.

The ten earlier NAPI/RPS prerequisites are already present in v6.6, so this
series reverts the workaround and backports the four upstream changes (all
in upstream v6.10) in dependency order. Backlog-NAPI threads replace the
RPS/defer function-call notifications; ordinary scheduler wakeup IPI traffic
can still occur. Two of the changes were previously backported to ordinary
6.6.y and reverted (507692c05636, 5a530c8ead06) only because PREEMPT_RT is
absent there, not for a functional defect.

Backport notes
--------------
Only 3/5 needs context adaptations; they are listed in that patch's commit
message. The other four apply without context edits. Unlike v6.1, v6.6 keeps
WRITE_ONCE(napi->list_owner, ...) because the field already exists here.

Verification
------------
Each of the five stages was replayed against the base snapshot and compiled
for net/core/dev.o and net/core/skbuff.o. The baseline and final RT/RPS
bzImages were built with byte-identical normalized configs using GCC 9.4.0,
with no compiler warnings or errors.

Tests use virtme-ng 1.38, x86_64 QEMU/KVM, four vCPUs and 2 GiB memory:

  vng --run <bzImage> --cpus 4 --memory 2G \
      --qemu-opts='-machine accel=kvm' --exec 'bash <script>'

The config enables PREEMPT_RT, SMP, SYSFS, NET_NS, VETH, RPS,
IRQ_TIME_ACCOUNTING and KPROBES, with NR_CPUS=4. Run the inline script below
in a fresh guest for each image; it prints one column of the table, and the
columns are joined outside the guest. It covers both mechanisms: the RPS/IPI
path (ping flood with RPS steered to CPU1) and the defer_list purge path
(cross-CPU TCP frees traced with kprobes). See its header for details.

  #!/bin/bash
  # Run only in a fresh virtme guest; keep host networking and logs untouched.
  # One run prints both metric groups of the A/B table:
  #   IPI/RPS   : hardirq time, received_rps, function-call IPIs, flush WARNs
  #   defer_list: skb_attempt_defer_free vs the purge trigger that fires
  # MODE=rps sends RPS to CPU1; MODE=local keeps it on CPU0; MODE=norps has RPS off.

  set -euo pipefail
  export LC_ALL=C
  SECS=${SECS:-20}; MODE=${MODE:-rps}; CPU=1; MASK=2
  [[ $MODE == rps ]] || { CPU=0; MASK=1; }
  grep -q 'virtme' /proc/cmdline
  [[ $(cat /sys/kernel/realtime) == 1 ]]
  HZ=$(getconf CLK_TCK)
  command -v iperf3 >/dev/null || { echo 'SKIP: iperf3 missing'; exit 0; }
  # The guest root is read-only; iperf3 needs a writable temp dir to start.
  TMPDIR=$(for d in /var/tmp /dev/shm /run /root /tmp; do [ -w "$d" ] && { echo "$d"; break; }; done)
  [ -n "$TMPDIR" ] && export TMPDIR || { echo 'SKIP: no writable TMPDIR'; exit 0; }
  TR=/sys/kernel/tracing
  [[ -d $TR ]] || { mountpoint -q /sys/kernel/debug || mount -t debugfs none /sys/kernel/debug; TR=/sys/kernel/debug/tracing; }
  [[ -d $TR ]] || { echo 'SKIP: no tracing dir'; exit 0; }

  NS=bn$$; TX=bn$$t; RX=bn$$r
  PROBES='def_free kick trig'
  cleanup() {
      ip link del "$TX" 2>/dev/null || true
      ip netns del "$NS" 2>/dev/null || true
      for p in $PROBES; do { echo "-:$p" > "$TR/kprobe_events"; } 2>/dev/null || true; done
  }
  trap cleanup EXIT
  ip netns add "$NS"
  ip link add "$TX" type veth peer name "$RX"
  ip link set "$RX" netns "$NS"
  ip addr add 192.0.2.1/24 dev "$TX"
  ip link set "$TX" up
  ip netns exec "$NS" ip addr add 192.0.2.2/24 dev "$RX"
  ip netns exec "$NS" ip link set "$RX" up
  if [[ $MODE != norps ]]; then
      ip netns exec "$NS" sh -c "printf '%s\n' '$MASK' > /sys/class/net/$RX/queues/rx-0/rps_cpus"
      printf 'RPS_MASK='
      ip netns exec "$NS" sh -c "cat /sys/class/net/$RX/queues/rx-0/rps_cpus"
  fi
  printf 'KERNEL=%s MODE=%s CPU=%s SECS=%s USER_HZ=%s\n' "$(uname -r)" "$MODE" "$CPU" "$SECS" "$HZ"
  uname -v
  ps -eo pid,cls,rtprio,psr,comm | grep -E 'backlog_napi|ksoftirqd' || true
  for p in $(ps -eo pid,comm | awk '$2 ~ /^backlog_napi\// {print $1}'); do taskset -pc "$p"; done

  # ---- IPI/RPS path: CPU0 floods the veth, RPS steers RX to $CPU ----
  # Connectivity check also warms up ARP and avoids charging WARN output to load.
  taskset -c 0 ping -n -q -c 3 -W 2 192.0.2.2
  irq() { awk -v c="cpu$CPU" '$1==c {print $7}' /proc/stat; }
  field() { awk -v c="$CPU" -v f="$1" 'NR==c+1 {print $f}' /proc/net/softnet_stat; }
  # CPU n is field n+2 on the "CAL: ... Function call interrupts" line.
  cal() { awk -v c="$((CPU+2))" '/Function call interrupts/ {print $c}' /proc/interrupts; }
  i0=$(irq); sleep "$SECS"; i1=$(irq)
  r0=$(field 10); c0=$(cal); j0=$(irq)
  rc=0
  PING=$(timeout -s INT "$SECS" taskset -c 0 ping -n -f -q 192.0.2.2 2>&1) || rc=$?
  [[ $rc == 124 || $rc == 0 ]] || { printf '%s\n' "$PING"; exit "$rc"; }
  j1=$(irq); r1=$(field 10); c1=$(cal)
  printf '%s\n' "$PING"
  printf '%s\n' "$PING" | awk '/packets transmitted/ {ok=($1>0 && $4>0)} END {exit !ok}'
  printf 'IDLE_IRQ_MS=%s LOAD_IRQ_MS=%s RPS_CALLBACKS=%s CALL_IPI=%s\n' \
      "$(((i1-i0)*1000/HZ))" "$(((j1-j0)*1000/HZ))" \
      "$((16#$r1-16#$r0))" "$((c1-c0))"
  # A WARN header is one warning; repeated symbol names in its stack are not.
  LOG=$(dmesg)
  printf 'TARGET_WARNINGS=%s\n' "$(printf '%s\n' "$LOG" | grep -cE 'WARNING:.*do_softirq_post_smp_call_flush' || true)"

  # ---- defer_list path: skb alloc on CPU0, freed by a CPU1 reader ----
  # kick_defer_list_purge exists only in the patched tree. kprobe_events events
  # are created disabled, so each probe must be enabled explicitly.
  for spec in 'def_free skb_attempt_defer_free' 'kick kick_defer_list_purge' \
              'trig trigger_rx_softirq'; do
      set -- $spec
      { echo "p:$1 $2" >> "$TR/kprobe_events"; } 2>/dev/null || echo "PROBE_ABSENT=$2"
      { echo 1 > "$TR/events/kprobes/$1/enable"; } 2>/dev/null || true
  done
  # A probe that never registered has no counter; report that explicitly rather
  # than as a misleading zero.
  hits() {
      [ -r "$TR/events/kprobes/$1/enable" ] || { echo ABSENT; return; }
      awk -v n="$1" '$1==n {print $2}' "$TR/kprobe_profile" 2>/dev/null | grep . || echo 0
  }
  printf '4\n' > /proc/sys/net/core/skb_defer_max
  ip netns exec "$NS" taskset -c 1 iperf3 -s -1 -p 5201 >/dev/null 2>&1 &
  SRV=$!
  sleep 1
  taskset -c 0 iperf3 -c 192.0.2.2 -p 5201 -t "$SECS" -P 4 >/dev/null 2>&1 || true
  wait "$SRV" 2>/dev/null || true
  sleep 2   # let any pending purge drain before sampling
  D=$(hits def_free); K=$(hits kick); T=$(hits trig)
  printf 'HITS def_free=%s kick=%s trig=%s\n' "$D" "$K" "$T"
  [[ $D -gt 0 ]] && echo 'DEFER_PATH=REACHED' || echo 'DEFER_PATH=NOT_REACHED'

  printf '%s\n' '--- softnet_stat ---'; cat /proc/net/softnet_stat
  # Only the warning block is evidence; the rest of dmesg is boot noise.
  printf '%s\n' '--- WARNING ---'
  printf '%s\n' "$LOG" | grep -A20 -E 'WARNING:.*do_softirq_post_smp_call_flush' || true

Two images are compared: the unmodified base (4c4970859022, no patches) and the
patched image (all five patches). Each was booted twice in a fresh guest; the
table shows the first run, and the repeat is consistent with it.

                          Baseline       Patched
  Idle hardirq (ms)             10            10
  Load hardirq (ms)            900            40
  received_rps delta     2,390,909             0
  Function-call IPIs     2,390,695           947
  Echo requests received 2,390,916     2,473,383
  Target WARNING records         1             0
  skb_attempt_defer_free() 1,075,050     1,558,153
  kick_defer_list_purge()   absent       193,560
  trigger_rx_softirq()     176,249             0


Sebastian Andrzej Siewior (4):
  net: Remove conditional threaded-NAPI wakeup based on task state.
  net: Allow to use SMP threads for backlog NAPI.
  net: Use backlog-NAPI to clean up the defer_list.
  net: Rename rps_lock to backlog_lock.

Wen Yang (1):
  Revert "net: Avoid the IPI to free the"

 include/linux/netdevice.h |   5 +-
 net/core/dev.c            | 252 ++++++++++++++++++++++++--------------
 net/core/skbuff.c         |   9 +-
 3 files changed, 161 insertions(+), 105 deletions(-)

-- 
2.25.1

