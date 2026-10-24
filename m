Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848650;
	b=EusoYKiSCC0mgEVwrD7yCX+i66pS1Wicrzaj8AyA0d3Nw58wC4EUlf2kEAMV6jD6a8Qm
	 5Fyq2/BrCLLyKrCmzSsKHnqsUlZqmojDuNb6+sNYof7GCz/kmtdcOSnDYzdBctOS8DKXY
	 dI+xxfSUy8ZSkYYV4TBUq97FUtlij6YSjAzE7bTFjGUjp0fwinPU6U2jEcsUWcfl9uNd5
	 W3zKk5iWCutdyvyeN4gkdL/+pi1tDPJywWVVcP518IMpUera3b+kBVrXciqLEPLoLplYp
	 e3mEgavBydfd+yMgobnlmPtWoC3BltX29s1CwZHuVl4G7YZ79EJwAd5StV6LF2VeHTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848650;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JMRt7rJPXPcARxUK6s7H9SY/U6y3tk2GjmMDJbMd+CI=;
	b=RuXIKEfwExTqm000l3osiaqlxojjYBG8doUfH8B7CONrRgaM2Ich+hKmsyyv5t/RtExI
	 BONtmCa/HIYLisRP78B9XCew4dUVFtaMK/dFsJOUu9oBV1jstJh56xH4JfAtXC8xPxwIP
	 cG+q6Jc8MveGbV0tckF3NoMu7NmGq4NOl/+BK0DwtusmE7fEuUHqd/GyPEILrIVFotdT3
	 eSiQbrRNDCWjbC02dhqaLNHVPww7q9YuqB42xUP+LC89b9OyoOiLYWUyMGwD3GdT5HtpD
	 RIIhYxPYVzHMhELStP3FEIuXspTqA4cn/wI8yVAdogQVTANI4rApP7B1UwEQa0Iz4Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vSeMs3n0;
	arc=none smtp.remote-ip=95.215.58.15
Received: from mta1.migadu.com (out-15.mta1.migadu.com [95.215.58.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E983606A31E
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 13:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E983606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vSeMs3n0
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=av5UBGTD5N0nshuFf6bT8k3hSLsVBbNFZHiiF298YkI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792848646; v=1; x=1793453446;
 b=vSeMs3n0drL+H0mvnfUgfAczEkXJYsN3/7BeBXGXQsKYS0YjcVwXeSV+giHnKiFMqvrqgd6w
 uTNnvjQalQd/IoM99dHAssyPyW3c0fBXLaxQgFB+KnXLEUg8QHCpUuE9gygdCBCHtbf+y9nhbNp
 XtxH16GP4eIh3oa1KxiIhGt4=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id 01e9a5a2a190b8b0;
	Sat, 24 Oct 2026 13:30:45 +0000
X-Mizu-Trace-ID: 01e9a5a2a190b8b0
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.1-rt v2 00/15] net: Backport backlog-NAPI threads to resolve PREEMPT_RT softirq warning in SMP flush
Date: Sat, 24 Oct 2026 21:30:24 +0800
Message-Id: <cover.1792847031.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
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

From: Wen Yang <wen.yang@linux.dev>

Backport the backlog-NAPI smpboot-thread mechanism and its prerequisite
NAPI/RPS/defer_list work from upstream (v6.4 - v6.9) to v6.1-rt-next.

Issues
------
On PREEMPT_RT, RPS steers packets to a remote CPU's backlog by sending an
IPI. The IPI handler (rps_trigger_softirq) calls ____napi_schedule(), which
raises NET_RX_SOFTIRQ. do_softirq_post_smp_call_flush() then sees a softirq
pending that was not pending before the flush, and NET_RX_SOFTIRQ is not
masked by SCHED_SOFTIRQ_MASK, so it fires:

  WARNING: CPU: 1 PID: 0 at kernel/softirq.c:315 do_softirq_post_smp_call_flush+0x3d/0x50
  Call Trace:
   <TASK>
   flush_smp_call_function_queue+0x50/0x70
   do_idle+0x178/0x260
   cpu_startup_entry+0x21/0x30

The same path then calls invoke_softirq() -> wakeup_softirqd() with IRQs
disabled in interrupt context, which the RT maintainers consider a design
violation ("raising a softirq from an SMP call function").

Commit 8d152d22d9f0 ("net: Avoid the IPI to free the") worked around this
only for the skb defer_list by delegating the purge to a workqueue. That was
incomplete: it did not touch RPS steering, and workqueue scheduling adds
latency to deferred skb recycling.

Solution
--------
Upstream v6.9 dad6b9770263 ("net: Allow to use SMP threads for backlog NAPI")
adds per-CPU smpboot threads ("backlog_napi/%u"). On PREEMPT_RT
use_backlog_threads() is unconditionally true, so cross-CPU backlog and
defer_list work bypasses IPIs and softirqs entirely:
  1) Cross-CPU backlog enqueue sets NAPI_STATE_SCHED_THREADED and wakes the
     remote CPU's backlog_napi thread with wake_up_process().
  2) defer_list cleanup is folded into the same thread (80d2eefcb4c8).
  3) The old defer_work workaround is reverted (patch 01).

Backport notes
--------------
All 15 patches apply cleanly in sequence against 6271c130c6e5. Two patches
needed hand work. Every deviation from the upstream text is listed below,
together with the base difference that forced it -- there is no edit made
just for the sake of editing.

1. Patch 06 (____napi_schedule): upstream 8b43fd3d1d7d writes
   __raise_softirq_irqoff(); the backport keeps raise_softirq_irqoff().
   Reason: 6.1-rt's ____napi_schedule() already uses raise_softirq_irqoff(),
   because stable 533824e6a0fb (upstream 77e45145e303, "net: Handle
   napi_schedule() calls from non-interrupt") deliberately added the
   ksoftirqd wakeup there to fix the NOHZ tick-stop "local softirq work is
   pending" stall. Applying the 2023 upstream text verbatim would silently
   revert that later fix. The 2023 commit predates it, so this is a
   forward-port artefact, not a behavioural choice.

2. Patch 13 (backlog-NAPI threads): five hunks were re-anchored. None changes
   behaviour; each is forced by a 6.1-vs-v6.9 base difference, verified
   against 6271c130c6e5:
   a) backlog_napi percpu definition
        upstream anchor : "unsigned int sysctl_skb_defer_max"
        6.1 anchor      : "int netdev_max_backlog"
      Both variables sit in the same block right after the "Receiver
      routines" comment, so the declaration lands in the identical place.
      Pure textual anchor.

   b) ____napi_schedule(): WRITE_ONCE(napi->list_owner, ...) dropped
      napi_struct has no list_owner member on 6.1 (grep over 6271c130c6e5's
      netdevice.h returns nothing), so keeping the line does not compile.
      list_owner only backs the napi_by_id()/list-ownership bookkeeping from
      a later upstream series; it is not consulted anywhere on the backlog
      path, so omitting it cannot change behaviour.

   c) napi_threaded_poll() split into napi_threaded_poll_loop() + wrapper
      Not a deviation: the same split, applied to 6.1's function body, which
      after patches 09-11 is textually the upstream pre-image. Verified: the
      extracted napi_threaded_poll_loop() is byte-identical between upstream
      dad6b9770263 and this backport.

   d) smpboot block anchor
      Upstream anchors the new backlog_threads block on the code following
      net_page_pool_create(); 6.1 has no net_page_pool_create() (0
      occurrences in 6271c130c6e5). The block is anchored on the comment
      preceding net_dev_init() instead. The inserted code is identical.

   e) net_dev_init()
      Same cause: the "if (net_page_pool_create(i)) goto out;" context lines
      do not exist on 6.1 and were dropped. Both substantive additions are
      kept verbatim, and one of them is load-bearing, not cosmetic:
        INIT_LIST_HEAD(&sd->backlog.poll_list);

      6.1 never initialises backlog.poll_list (no INIT_LIST_HEAD and no
      netif_napi_add for the backlog NAPI in 6271c130c6e5's dev.c). That was
      harmless while the backlog NAPI was only ever reached via
      list_add_tail(), which does not require a pre-initialised node. The
      threaded path calls __napi_poll() on the backlog NAPI with no
      list_add() at all, and __napi_poll() tests:

          if (unlikely(!list_empty(&n->poll_list))) {
                  pr_warn_once("%s: Budget exhausted after napi rescheduled\n",
                               n->dev ? n->dev->name : "backlog");
                  return work;          /* leaves *repoll unset */
          }

      (the "backlog" fallback in that message shows upstream expects this
      NAPI to reach it). On a zeroed node list_empty() returns false, so the
      backlog thread would take this branch on every budget exhaustion,
      print the spurious "backlog: Budget exhausted after napi rescheduled"
      warning and stop repolling. The INIT_LIST_HEAD is therefore required
      for correctness on 6.1, exactly as it is upstream.

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

The repeat agrees within noise: baseline load hardirq 930 ms, 2,455,171
received_rps and 2,455,170 function-call IPIs, 1 WARNING; patched 40 ms, 0
received_rps and 825 function-call IPIs, 0 WARNING.

Eric Dumazet (9):
  net: napi_schedule_rps() cleanup
  net: add softnet_data.in_net_rx_action
  net: optimize napi_schedule_rps()
  net: optimize ____napi_schedule() to avoid extra NET_RX_SOFTIRQ
  net: add debugging checks in skb_attempt_defer_free()
  net: do not provide hard irq safety for sd->defer_lock
  net: move skb_defer_free_flush() up
  net: make napi_threaded_poll() aware of sd->defer_list
  net: optimize napi_threaded_poll() vs RPS/RFS

Jesper Dangaard Brouer (1):
  net: avoid irqsave in skb_defer_free_flush

Sebastian Andrzej Siewior (4):
  net: Remove conditional threaded-NAPI wakeup based on task state.
  net: Allow to use SMP threads for backlog NAPI.
  net: Use backlog-NAPI to clean up the defer_list.
  net: Rename rps_lock to backlog_lock.

Wen Yang (1):
  Revert "net: Avoid the IPI to free the"

 include/linux/netdevice.h |   9 +-
 net/core/dev.c            | 304 +++++++++++++++++++++++++-------------
 net/core/skbuff.c         |  17 +--
 3 files changed, 215 insertions(+), 115 deletions(-)

-- 
2.25.1

